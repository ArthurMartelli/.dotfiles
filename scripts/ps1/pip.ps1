$Programs =
"black",
"pdf-cli",
"numpy",
"pandas",
"Django"

foreach ($programItem in $Programs) {
    pip install $programItem
}