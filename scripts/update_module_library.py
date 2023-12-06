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
responseData = response.json()
repos = responseData.get("items")

####################################################################################
# Create Markdown table containing all Terraform Baseline modules
####################################################################################

table = []
columnSeparator = " | "
rowSeparator = "\n"

values = {
    "Module": "{moduleName}",
    "Repository": "[{repoName}]({repoUrl})",
    "Latest release": "{latestRelease}",
}

columns = values.keys()
table.append(columnSeparator.join(columns))
table.append(columnSeparator.join(["---"] * (len(columns))))

for repo in repos:
    repoName = repo.get("name", "N/A")
    moduleName = repoName.replace("terraform-azurerm-", "")
    repoUrl = repo.get("html_url", "N/A")
    latestRelease = repo.get("latest_release", "N/A")

    row = []
    for column in columns:
        row.append(values.get(column))

    markdownRow = columnSeparator.join(row).format(
        moduleName=moduleName,
        repoName=repoName,
        repoUrl=repoUrl,
        latestRelease=latestRelease,
    )
    table.append(markdownRow)

markdownTable = rowSeparator.join(table)

if len(templatePath) == 0:
    markdown = "# Module library\n\n{markdownTable}\n"
else:
    with open(templatePath, "r") as templateFile:
        markdown = templateFile.read()
        templateFile.close()

with open(outputPath, "w") as outputFile:
    outputFile.write(markdown.format(markdownTable=markdownTable))
    outputFile.close()
