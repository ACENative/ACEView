/usr/local/bin/appledoc \
--project-name "ACEView" \
--project-company "Code of Interest" \
--company-id "com.codeofinterest" \
--docset-atom-filename "ACEView.atom" \
--docset-feed-url "http://faceleg.github.com/ACEView/%DOCSETATOMFILENAME" \
--docset-package-url "http://faceleg.github.com/ACEView/%DOCSETPACKAGEFILENAME" \
--docset-fallback-url "http://faceleg.github.com/ACEView/" \
--output "~/help" \
--publish-docset \
--logformat xcode \
--keep-undocumented-objects \
--keep-undocumented-members \
--keep-intermediate-files \
--no-repeat-first-par \
--no-warn-invalid-crossref \
--ignore "*.m" \
--ignore "ACELogger.h" \
--index-desc "README.md" \
./ACEView
