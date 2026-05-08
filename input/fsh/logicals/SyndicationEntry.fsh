Invariant: entry-retract-no-alternate-link
Description: "Retract entries (any category term ending '_RETRACT') MUST NOT carry a link with rel='alternate' — there is nothing to download."
Severity: #error
Expression: "category.where(term.endsWith('_RETRACT')).empty() or link.where(rel = 'alternate').empty()"

Invariant: entry-non-retract-has-link
Description: "Non-retract entries MUST carry at least one link."
Severity: #error
Expression: "category.where(term.endsWith('_RETRACT')).exists() or link.exists()"

Logical: SyndicationEntry
Id: syndication-entry
Title: "Terminology Syndication Entry"
Description: """
An Atom `<entry>` (RFC 4287 §4.1.2) representing a single syndicated
artefact set — for example an RF2 release package, a FHIR
CodeSystem, a FHIR ValueSet, or a FHIR NPM package.

An entry combines the Atom 1.0 entry model with three extension
namespaces: NCTS ASF (terminology metadata), SNOMED CT (package
dependencies, MD5 hashes), and Ontoserver (permissions, validation
state).

## Cross-field semantics

When an entry's artefact is a FHIR canonical resource (CodeSystem,
ValueSet, ConceptMap, NamingSystem, StructureDefinition, …):

- `contentItemIdentifier` SHOULD equal the resource's `url`.
- `contentItemVersion` SHOULD equal `<url>|<version>`.
- `<published>` SHOULD equal the resource's `date`.
- `<title>` SHOULD equal the resource's `title` where present, else `name`.
- `<rights>` SHOULD reflect the resource's `copyright`.

When the artefact is a SNOMED CT module:

- `contentItemIdentifier` SHOULD be the unversioned SNOMED CT module URI
  (`http://snomed.info/sct/<moduleId>`).
- `contentItemVersion` SHOULD be the versioned SNOMED CT URI
  (`http://snomed.info/sct/<moduleId>/version/<YYYYMMDD>`).
"""
Characteristics: #can-be-target

// ── Atom core ─────────────────────────────────────────────────────────────
* id 1..1 uri "Atom `<id>`. Permanent, globally-unique identifier for this entry. Conventionally `urn:uuid:<uuid>`. MUST NOT change when the entry is updated (RFC 4287 §4.2.6)."
* title 1..1 string "Atom `<title>`. Human-readable entry name."
* summary 0..1 string "Atom `<summary>`. Short description of the artefact's content and intended use."
* rights 0..1 string "Atom `<rights>`. Copyright/licence statement applicable to the artefact."
* published 0..1 dateTime "Atom `<published>`. The instant the artefact set was first issued by its publisher. For FHIR canonical resources, SHOULD equal the resource's `date`."
* updated 1..1 dateTime "Atom `<updated>`. The instant this entry's metadata or artefacts last meaningfully changed. For FHIR canonical resources whose content has changed, SHOULD equal the resource's `meta.lastUpdated` or `date`."
* author 0..* BackboneElement "Atom `<author>`. The party that produced the artefact."
  * name 1..1 string "Author display name."
  * uri 0..1 uri "Author URI (typically organisation homepage)."
  * email 0..1 string "Author contact email."
* category 1..* SyndicationCategory "Atom `<category>`. At least one category MUST be present, and at least one category SHOULD use a registered scheme so consumers can determine the artefact type (see SyndicationContentType)."
* link 0..* SyndicationLink "Atom `<link>`. For non-retract entries at least one link MUST be present — the primary artefact uses `rel=\"alternate\"`; ancillary documents (release notes, licence) use `rel=\"related\"`. Retract entries MUST NOT carry any `rel=\"alternate\"` link (there is nothing to download); they MAY carry `rel=\"related\"` links — see `entry-retract-no-alternate-link` and `entry-non-retract-has-link`."
* obeys entry-retract-no-alternate-link
* obeys entry-non-retract-has-link
* source 0..1 SyndicationFeedMetadata "Atom `<source>` (RFC 4287 §4.2.11). Identifies the originating feed when this entry has been copied, mirrored, or aggregated from another feed. SHOULD be set whenever the entry has been included in a feed other than its publisher's primary feed."

// ── NCTS ASF extensions ──────────────────────────────────────────────────
* contentItemIdentifier 1..1 uri "`ncts:contentItemIdentifier`. Canonical, version-independent identifier for the artefact. Stable across versions of the same logical artefact. For FHIR canonical resources, equals the resource's `url`. For SNOMED CT modules, the unversioned module URI."
* contentItemVersion 1..1 uri "`ncts:contentItemVersion`. Canonical, version-specific identifier for this exact release. MUST be unique per `<entry>` within a feed (two entries with the same `contentItemVersion` are duplicates). For FHIR canonical resources, equals `<url>|<version>`. For SNOMED CT modules, the versioned module URI."
* fhirVersion 0..1 string "`ncts:fhirVersion`. The FHIR version the artefact targets, when the artefact is FHIR. Format: `<major>.<minor>` or `<major>.<minor>.<patch>` (e.g. `4.0.1`). Maximum length 5. MUST be present when at least one category has a `FHIR_*` term — including the `FHIR_*_RETRACT` retraction terms."
* fhirProfile 0..* uri "`ncts:fhirProfile`. Canonical URL(s) of the FHIR StructureDefinition(s) the artefact claims conformance to. Repeats for multiple profiles. Only meaningful when the artefact is FHIR."
* bundleInterpretation 0..1 code "`ncts:bundleInterpretation`. For artefacts that are FHIR Bundles: the intended load semantics. Permitted values: `batch`, `collection`. When absent for a Bundle artefact, consumers SHOULD default to `batch`. SHOULD be absent on retract entries."

// ── SNOMED CT extensions ─────────────────────────────────────────────────
// Used when the artefact is a SNOMED CT extension or derivative that
// requires another package to be loaded first.
* packageDependency 0..1 BackboneElement "`sct:packageDependency`. Inter-package dependencies. Present only when the artefact requires other SNOMED CT packages (i.e. is an extension or derivative — not for an Edition itself). SHOULD be absent on retract entries."
  * editionDependency 0..* uri "`sct:editionDependency`. Versioned SNOMED CT URI of an edition this package depends on. Format: `http://snomed.info/sct/<moduleId>/version/<YYYYMMDD>`."
  * derivativeDependency 0..* uri "`sct:derivativeDependency`. Versioned SNOMED CT URI of a derivative this package depends on."

// ── Ontoserver extensions ────────────────────────────────────────────────
* permission 0..* BackboneElement "`onto:permission`. Authorisation tag(s) that gate access to this entry's artefacts. An empty permission set means no entry-specific authorisation is required beyond feed-level access."
  * code 1..1 string "Permission tag. Compared against the set of permissions held by the requesting principal."
