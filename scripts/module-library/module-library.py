#!/usr/bin/env python3

import requests
from argparse import ArgumentParser

parser = ArgumentParser()
parser.add_argument("-t", "--template", type=str, default="")
parser.add_argument("-o", "--output", type=str, default="module-library.md")
args = parser.parse_args()
templatePath = args.template
outputPath = args.output

####################################################################################
# Get all repos in org "equinor" with topic "terraform-baseline"
####################################################################################

githubOrg = "equinor"
githubTopic = "terraform-baseline"

url = "https://api.github.com/search/repositories?q=org:{org} topic:{topic}".format(
    org=githubOrg, topic=githubTopic
)
response = requests.get(url)
responseJson = response.json()
repos = responseJson.get("items")
reposSorted = sorted(repos, key=lambda repo: repo["name"])

####################################################################################
# Create Markdown table containing all Terraform Baseline modules
####################################################################################

rows = []
columnSeparator = " | "
rowSeparator = "\n"

dict = {
    "Module": "{moduleName}",
    "Repository": "[{repoFullName}]({repoUrl})",
    "Latest release": "[![Release](https://img.shields.io/github/v/release/{repoFullName}?display_name=tag&sort=semver)]({repoUrl}/releases)",
}

columns = dict.keys()
rows.append(columnSeparator.join(columns))
rows.append(columnSeparator.join(["---"] * (len(columns))))

row = columnSeparator.join(dict.values())

for repo in reposSorted:
    repoName = repo.get("name", "N/A")
    moduleName = repoName.replace("terraform-azurerm-", "")
    repoFullName = repo.get("full_name", "N/A")
    repoUrl = repo.get("html_url", "N/A")

    rows.append(
        row.format(
            moduleName=moduleName,
            repoName=repoName,
            repoFullName=repoFullName,
            repoUrl=repoUrl,
        )
    )

table = rowSeparator.join(rows)

####################################################################################
# Create Markdown file containing table
####################################################################################

if len(templatePath) != 0:
    with open(templatePath, "r") as templateFile:
        markdownTemplate = templateFile.read()
        templateFile.close()
else:
    # Fall back on simple template with header and table
    markdownTemplate = "# Module library\n\n{table}\n"

with open(outputPath, "w") as outputFile:
    outputFile.write(markdownTemplate.format(table=table))
    outputFile.close()
