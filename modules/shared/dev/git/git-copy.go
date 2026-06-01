package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"net/url"
	"os"
	"os/exec"
	"path"
	"path/filepath"
	"strings"
)

func main() {
	log.SetOutput(os.Stderr)
	log.SetFlags(0)

	if len(os.Args) < 2 || os.Args[1] == "--help" {
		log.Fatalf("Use: %s <url> ...<git-flags>\n", filepath.Base(os.Args[0]))
	}

	rawURL := os.Args[1]
	extraArgs := os.Args[2:]

	cloneURI, cloneDir, err := parseURL(rawURL)
	if err != nil {
		log.Fatal(err)
	}

	// Adjust clone directory
	username := getGitHubUsername()
	if username != "" && strings.HasPrefix(cloneDir, username+"/") {
		cloneDir = strings.TrimPrefix(cloneDir, username+"/")
	} else if !strings.HasPrefix(cloneDir, "aur/") {
		cloneDir = filepath.Join("others", strings.ReplaceAll(cloneDir, "/", "_"))
	}

	homeDir, err := os.UserHomeDir()
	if err != nil {
		log.Fatal(err)
	}
	targetDir := filepath.Join(homeDir, "git", cloneDir)

	args := []string{"clone", cloneURI, targetDir}
	args = append(args, extraArgs...)

	cmd := exec.Command("git", args...)
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	if err := cmd.Run(); err != nil {
		log.Fatal(err)
	}
}

// parseURL takes a raw URL (HTTPS, SSH, or custom prefix) and returns the git clone URI
// and the local directory path relative to ~/git.
func parseURL(raw string) (uri, dir string, err error) {
	// Expand custom short prefixes
	if strings.HasPrefix(raw, "gh:") {
		raw = "git@github.com:" + raw[3:]
	} else if strings.HasPrefix(raw, "me:") {
		raw = "git@github.com:zedxihan/" + raw[3:]
	} else if strings.HasPrefix(raw, "aur:") {
		pkg := strings.TrimSuffix(raw[4:], ".git")
		return "ssh://aur@aur.archlinux.org/" + pkg + ".git", "aur/" + pkg, nil
	}

	// 1. Handle SSH format (e.g. git@github.com:user/repo.git)
	if strings.HasPrefix(raw, "git@") {
		parts := strings.SplitN(raw, ":", 2)
		if len(parts) != 2 {
			return "", "", errors.New("invalid SSH URL format")
		}
		host := strings.TrimPrefix(parts[0], "git@")
		cleanPath := strings.TrimSuffix(parts[1], ".git")
		if host == "aur.archlinux.org" {
			pkg := path.Base(cleanPath)
			return raw, "aur/" + pkg, nil
		}
		return raw, cleanPath, nil
	}

	// 2. Handle HTTP/HTTPS/SSH schemes
	u, err := url.Parse(raw)
	if err != nil {
		return "", "", err
	}
	pathStr := strings.TrimSuffix(strings.TrimPrefix(u.Path, "/"), ".git")

	switch u.Host {
	case "github.com", "gitlab.com":
		cleanPath, _, _ := cutNthSep(pathStr, "/", 2)
		return "git@" + u.Host + ":" + cleanPath, cleanPath, nil
	case "gist.github.com":
		gistID, _, _ := strings.Cut(pathStr, "/")
		return "git@" + u.Host + ":" + gistID, pathStr, nil
	case "aur.archlinux.org":
		pkg := path.Base(pathStr)
		return "ssh://aur@" + u.Host + "/" + pkg + ".git", "aur/" + pkg, nil
	}
	return "", "", fmt.Errorf("unsupported host: %s", u.Host)
}

// getGitHubUsername returns the GitHub login of the active gh user, or empty string.
func getGitHubUsername() string {
	// gh auth status --active --jq '.[][][].login' --json hosts
	cmd := exec.Command("gh", "auth", "status", "--active", "--jq", ".[][][].login", "--json", "hosts")
	out, err := cmd.Output()
	if err != nil {
		return ""
	}
	var result string
	if err := json.Unmarshal(out, &result); err != nil {
		result = strings.TrimSpace(string(out))
	}
	return result
}

func cutNthSep(s string, sep string, n int) (before, after string, found bool) {
	if n <= 0 || sep == "" {
		return s, "", false
	}
	idx := 0
	for range n {
		match := strings.Index(s[idx:], sep)
		if match == -1 {
			return s, "", false
		}
		idx += match + len(sep)
	}
	cutIdx := idx - len(sep)
	return s[:cutIdx], s[idx:], true
}
