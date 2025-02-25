package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"

	"github.com/olekukonko/tablewriter"
)

func main() {
	// Create a scanner to read from stdin
	scanner := bufio.NewScanner(os.Stdin)
	var rows [][]string

	for scanner.Scan() {
		line := scanner.Text()
		if line == "" {
			continue
		}
		// Split the line into columns (space or tab-delimited)
		fields := strings.Fields(line)
		rows = append(rows, fields)
	}

	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "Error reading input:", err)
		os.Exit(1)
	}

	if len(rows) == 0 {
		fmt.Println("No data received.")
		return
	}

	// Create a table writer
	table := tablewriter.NewWriter(os.Stdout)
	for _, row := range rows {
		table.Append(row)
	}

	// Render the table
	table.Render()
}
