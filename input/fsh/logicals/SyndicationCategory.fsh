Invariant: category-term-scheme-binding
Description: "When scheme is one of the schemes registered in this IG, term MUST be drawn from that scheme's ValueSet: NCTS ASF (`…/asf/scheme/1.0.0`) → SyndicationContentTypeVS; Ontoserver RF2 binary-index (`…/rf2/1.0.0` or `…/rf2/2.0.0`) → OntoserverRf2IndexVS. Other schemes are unconstrained."
Severity: #error
Expression: "(scheme != 'http://ns.electronichealth.net.au/ncts/syndication/asf/scheme/1.0.0' or term.memberOf('https://ontoserver.csiro.au/syndication/ValueSet/syndication-content-type')) and (scheme != 'http://ontoserver.csiro.au/syndication/rf2/1.0.0' or term.memberOf('https://ontoserver.csiro.au/syndication/ValueSet/ontoserver-rf2-index')) and (scheme != 'http://ontoserver.csiro.au/syndication/rf2/2.0.0' or term.memberOf('https://ontoserver.csiro.au/syndication/ValueSet/ontoserver-rf2-index'))"

Logical: SyndicationCategory
Id: syndication-category
Title: "Terminology Syndication Category"
Description: """
An Atom `⟨category⟩` element classifying a syndication entry. The
`scheme` URI identifies the controlled vocabulary; `term` is the
machine code; `label` is the human-readable form.

The binding of `term` depends on `scheme`:

| `scheme`                                                                   | `term` ValueSet           |
|----------------------------------------------------------------------------|---------------------------|
| `http://ns.electronichealth.net.au/ncts/syndication/asf/scheme/1.0.0`      | SyndicationContentTypeVS  |
| `http://ontoserver.csiro.au/syndication/rf2/1.0.0`                         | OntoserverRf2IndexVS      |
| `http://ontoserver.csiro.au/syndication/rf2/2.0.0`                         | OntoserverRf2IndexVS      |
| any other scheme                                                            | unconstrained             |

This conditional rule is enforced by the `category-term-scheme-binding`
invariant. Slicing would be a more natural FHIR-level expression, but
slice declarations are not supported on Logical models.
"""
Characteristics: #can-be-target

* term 1..1 code "machine-readable code from the scheme"
* term ^definition = "Category term — machine-readable code from the scheme. The applicable ValueSet depends on `scheme`; the example binding below is the NCTS ASF ValueSet, the most common case. See `category-term-scheme-binding`."
* term from SyndicationContentTypeVS (example)

* scheme 1..1 uri "controlled vocabulary the term comes from"
* scheme ^definition = "Category scheme — the controlled vocabulary the term comes from."

* label 0..1 string "human-readable label for the term"

* obeys category-term-scheme-binding
