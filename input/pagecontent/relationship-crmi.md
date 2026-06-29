### Relationship to HL7 CRMI

The HL7 [Canonical Resource Management Infrastructure (CRMI)
IG](https://build.fhir.org/ig/HL7/crmi-ig/en/distribution.html#distribution-syndication)
defines a *distribution* framework for **knowledge artefacts** — `Measure`,
`Library`, `PlanDefinition`, and related clinical-reasoning resources, plus the
terminology resources they depend on. Among several distribution mechanisms
(FHIR Packages / NPM, the FHIR REST API, the `$package` operation, and version
manifests), CRMI also defines an **Atom-based syndication** feed.

That syndication feed and the feed specified by this guide are independently
designed Atom dialects that overlap in intent. This page documents how they
relate and shows how a single feed entry can conform to **both** so a publisher
need not choose.

### What CRMI defines

CRMI's syndication uses Atom 1.0 with one extension namespace,
`http://hl7.org/fhir/uv/crmi/syndication` (conventional prefix `hl7`), and four
entry-level elements:

| CRMI element | Values | This guide's analogue |
|--------------|--------|-----------------------|
| `<hl7:artifactType>` | `package`, `resource` | `<category term>` in the [NCTS ASF scheme](categories.html) (`FHIR_Package`, `FHIR_CodeSystem`, …) |
| `<hl7:artifactVersion>` | plain version, e.g. `0.2.1` | the version portion of `<ncts:contentItemVersion>` |
| `<hl7:fhirVersion>` | e.g. `4.0.1` | `<ncts:fhirVersion>` |
| `<hl7:publishAction>` | `publish`, `unpublish` | publish is implicit; `unpublish` ≈ a `*_RETRACT` [category](categories.html#retraction) |

CRMI's only normative statement is that the syndication API **SHALL** be based
on Atom; the specific link relations in its example are illustrative, not
normative. Two structural points matter for harmonisation:

- **The canonical URL is not an entry element in CRMI.** It is carried inside a
  linked FHIR transaction `Bundle` (a conditional create/delete by `url` +
  `version`). This guide instead requires the canonical to appear directly on
  the entry as `<ncts:contentItemIdentifier>` / `<ncts:contentItemVersion>`. A
  consequence is that a CRMI consumer cannot tell what a `resource` entry
  contains from its metadata alone — it must dereference and read the `Bundle`
  for every changed entry — whereas a dual-conformant entry exposes the
  canonical on the entry, so a client can decide whether it already holds that
  exact `url|version` with no round-trip. The same holds for `package` entries:
  CRMI does not require the link `href` to follow npm path conventions (only
  "SHALL be based on Atom" is normative), so a consumer cannot rely on the
  filename to identify the package and must read the tarball's `package.json`
  manifest to be sure.
- **CRMI's `unpublish` entry carries a `<link rel="alternate">`** — a delete
  transaction `Bundle`. This guide forbids `rel="alternate"` on a
  [retraction](entry-format.html#retraction-entries).

### Overlap, differences, and the one conflict

Almost everything reconciles by *adding* elements: the two extension namespaces
are independent, so an NCTS ASF consumer ignores `hl7:*` elements and a CRMI
consumer ignores `ncts:*` / `sct:*` / `onto:*` elements and `<category>`.

| Concept | This guide | CRMI | Reconcilable in one entry? |
|---------|-----------|------|----------------------------|
| Artefact type | `<category term=… scheme=…>` | `<hl7:artifactType>` | Yes — different places, no clash |
| Identity | `contentItemIdentifier` + `contentItemVersion` | `<hl7:artifactVersion>` (+ canonical in the Bundle) | Yes — emit both; the ASF keys are strictly richer |
| FHIR version | `<ncts:fhirVersion>` | `<hl7:fhirVersion>` | Yes — emit **both**, identical value |
| Publish | implicit | `<hl7:publishAction>publish` | Yes |
| Integrity | `ncts:sha256Hash` / `sct:md5Hash` on link | — | Yes — additive; CRMI ignores it |
| Permissions | `<onto:permission>` | — | Yes — additive |
| Feed profile | `<ncts:atomSyndicationFormatProfile>` | — | Yes — additive |
| **Withdrawal** | `*_RETRACT` category, **no** `rel="alternate"` | `unpublish` + delete Bundle at `rel="alternate"` | **Conflict** — see below |

The single genuine conflict is the **link relation on a withdrawal**. This
guide forbids `rel="alternate"` on a retraction; CRMI's example uses it for the
delete Bundle. Because CRMI's prose is silent on link relations (only "SHALL be
based on Atom" is normative), the cheaper resolution is to deliver the action
Bundle at **`rel="related"`**, which this guide already permits on a retraction.
The same pattern applies on the publish side: the artefact itself is the
`rel="alternate"` (carrying the hash), and CRMI's transaction Bundle is offered
as `rel="related"`.

> **Harmonisation ask to CRMI:** clarify that syndication consumers also honour
> action (create/delete) transaction Bundles delivered at `rel="related"`, not
> only `rel="alternate"`. In return, this guide contributes its per-link
> integrity hashes and per-entry permission model, which CRMI's syndication
> currently lacks.

### Worked example — a dual-conformant publish

A single entry that an NCTS ASF consumer **and** a CRMI consumer both accept.

```xml
<entry xmlns:ncts="http://ns.electronichealth.net.au/ncts/syndication/asf/extensions/1.0.0"
       xmlns:hl7="http://hl7.org/fhir/uv/crmi/syndication">
  <id>urn:uuid:1e7c3f92-6e2a-4c03-9f70-aa20b91b2c04</id>
  <title>Australian Body Sites</title>
  <updated>2024-06-15T09:00:00Z</updated>
  <published>2024-06-15T09:00:00Z</published>
  <!-- artefact type: ASF category + CRMI element -->
  <category term="FHIR_ValueSet" label="FHIR ValueSet"
            scheme="http://ns.electronichealth.net.au/ncts/syndication/asf/scheme/1.0.0"/>
  <hl7:artifactType>resource</hl7:artifactType>
  <hl7:publishAction>publish</hl7:publishAction>
  <!-- identity: ASF canonical keys + CRMI plain version -->
  <ncts:contentItemIdentifier>http://example.org/fhir/ValueSet/au-body-sites</ncts:contentItemIdentifier>
  <ncts:contentItemVersion>http://example.org/fhir/ValueSet/au-body-sites|1.2.0</ncts:contentItemVersion>
  <hl7:artifactVersion>1.2.0</hl7:artifactVersion>
  <!-- FHIR version: both elements, identical value -->
  <ncts:fhirVersion>4.0.1</ncts:fhirVersion>
  <hl7:fhirVersion>4.0.1</hl7:fhirVersion>
  <!-- primary artefact (ASF) with integrity -->
  <link rel="alternate" type="application/fhir+json"
        href="https://example.org/fhir/ValueSet?url=http://example.org/fhir/ValueSet/au-body-sites&version=1.2.0"
        length="83291"
        ncts:sha256Hash="9c9b…"/>
  <!-- CRMI transaction Bundle as related (see harmonisation ask) -->
  <link rel="related" type="application/fhir+json"
        href="https://example.org/fhir/Bundle/create-au-body-sites-1.2.0"/>
</entry>
```

A dual-conformant **withdrawal** entry — the hard case — is shown in
[Examples](examples.html#a-dual-conformant-crmi-withdrawal-entry).

### What does not map

Pure terminology artefacts — SNOMED CT RF2 packages, the Ontoserver RF2 binary
index, and LOINC releases — have no CRMI artefact type. For those entries, omit
the `hl7:*` elements; they are simply invisible to CRMI consumers, which is the
intended behaviour. Dual conformance only applies to the FHIR resource, Bundle,
and package entries that both specifications care about.
