Logical: SyndicationCategory
Id: syndication-category
Title: "Terminology Syndication Category"
Description: """
An Atom `<category>` element classifying a syndication entry. The
`scheme` URI identifies the controlled vocabulary; `term` is the
machine code; `label` is the human-readable form.

The NCTS ASF scheme `http://ns.electronichealth.net.au/ncts/syndication/asf/scheme/1.0.0`
is the most widely used scheme for terminology content types.
"""
Characteristics: #can-be-target

* term 1..1 code "Category term — machine-readable code from the scheme. See SyndicationContentType."
* scheme 1..1 uri "Category scheme — the controlled vocabulary the term comes from."
* label 0..1 string "Human-readable label for the term."
