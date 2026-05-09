CodeSystem: OntoserverRf2Index
Id: ontoserver-rf2-index
Title: "Ontoserver RF2 Binary Index Category"
Description: """
The single category term used by syndication entries that publish a
pre-built **Ontoserver RF2 binary index** — i.e. a zip file
containing the on-disk index Ontoserver builds from a SNOMED CT
RF2 release, ready to be consumed directly without re-indexing.

Consumers that recognise this artefact type can load the index
directly; consumers that do not MUST ignore the entry (the artefact
is not a SNOMED CT RF2 release).

## Wire-level scheme URI

On the wire, the Atom `category` element's `scheme` attribute carries one
of these URIs — not the canonical of this CodeSystem:

- `http://ontoserver.csiro.au/syndication/rf2/1.0.0`
- `http://ontoserver.csiro.au/syndication/rf2/2.0.0`

The trailing path segment is the **binary index format version** —
not the version of the SNOMED CT release contained in the index.
A consumer MUST match the scheme URI exactly: an index published as
`…/rf2/1.0.0` is not interchangeable with one published as
`…/rf2/2.0.0`.

The label paired with this term on the `category` element is conventionally
`Binary Index`.
"""
* ^url = "http://ontoserver.csiro.au/syndication/rf2"
* ^caseSensitive = true
* ^content = #complete
* ^experimental = false

* #BINARY "Binary Index" "A pre-built Ontoserver RF2 binary index — a zip containing the on-disk index Ontoserver derives from a SNOMED CT RF2 release. The companion `category` element's `scheme` attribute carries the binary-format version."
