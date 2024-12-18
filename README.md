# PoxVirus Genome Browser

Welcome to the **PoxVirus Genome Browser** repository! This project provides a genome browser featuring a phylogenetic tree for the poxvirus family. Users can visualize and interact with genomic assemblies, tracks, and a phylogenetic tree using JBrowse.

We have a static Github page to demonstrate the functionalities of our database. To experience all functionalities of our database. Download phylogenic_tree.nwk and session.json from this repository. Click Start a new empty session > Tools > Plugin store > Install MsaView and File > Import session > select session.json to view the phylogenic tree.

To view our static website [here](https://steve10166.github.io/jbrowse2).
---

## Prerequisites
Before using this repository, ensure you have the following:
- A working environment to run JBrowse (e.g., local machine, server, or cloud instance).

If you don't have JBrowse installed:
1. follow the instruction here: https://jbrowse.org/jb2/docs/
2. Modify the path at the beginning of the two .sh files in the script to the location where you have JBrowse installed.
---

## Installation and Usage Guide

### Step 1: Clone the Repository
Download the repository to your local machine:

```bash
git clone https://github.com/YourRepo/PoxVirusGenomeBrowser.git
cd PoxVirusGenomeBrowser
```

### Step 2: Download the Genomic Data from NCBI

```bash
cd Scripts
bash download.sh
```

### Step 3: Add assembly and tracks into JBrowse

```bash
bash add_assembly.sh
bash add_track.sh
```

### Step 4: Open JBrowse install and inspect data

Open JBrowse install and click File > Import session > select session.json downloaded from the repository.
