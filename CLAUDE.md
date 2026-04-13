# Discourse Easy Footer

A Discourse theme component that adds a responsive footer below the main Discourse footer.

- **Discourse meta thread:** https://meta.discourse.org/t/easy-responsive-footer/95818
- **License:** MIT

## What this component does

Renders a three-column footer (`below-footer` outlet) with:
- **First box** – configurable heading, blurb, and a PayPal donate button
- **Second box** – link sections (each with a title and list of links), rendered via the `sections` setting
- **Third box** – small links (privacy, ToS, About, etc.) and social media icon links

The footer is optionally shown to anonymous users on login-required pages via the `show_footer_on_login_required_page` setting.

## Stack
- JavaScript / Ember.js (Discourse frontend framework)
- Handlebars templates (.hbs files in javascripts/discourse/)
- SCSS for styling (common/ directory)
- Ruby for backend specs (spec/ directory)
- settings.yml defines admin-configurable settings

## Project structure

```
about.json                          # Theme metadata
settings.yml                        # All theme settings (heading, blurb, sections, small_links, social_links, svg_icons)
common/common.scss                  # Global styles
javascripts/discourse/
  components/custom-footer.hbs      # Main footer template (Glimmer)
  components/custom-footer.js       # Glimmer component (exposes heading + blurb from settings)
  connectors/below-footer/          # Outlet that mounts the footer on normal pages
  connectors/below-login/           # Outlet that optionally mounts the footer on login-required pages
migrations/settings/                # JS migration scripts (rename / transform legacy settings)
locales/                            # i18n translations (en.yml is canonical)
spec/system/footer_spec.rb          # RSpec system tests (run inside Discourse core)
spec/migrations/                    # RSpec unit tests for Ruby setting migrations
test/unit/migrations/settings/      # QUnit/JS tests for JS setting migrations
```

## Settings

| Key | Type | Purpose |
|-----|------|---------|
| `heading` | string (max 25) | Footer heading text |
| `blurb` | string (max 180) | Footer blurb text |
| `sections` | objects | Link columns – each has `text`, optional `title`, and nested `links` |
| `small_links` | objects | Bottom-row links (Privacy, ToS, About, etc.) |
| `social_links` | objects | Social icon links; icon name maps to a Font Awesome `fab-*` icon |
| `svg_icons` | list | Icons to load (pipe-separated, e.g. `fab-facebook|fab-twitter`) |
| `show_footer_on_login_required_page` | boolean | Show footer to anon users when login is required |

## Tooling

- **Package manager:** pnpm 9.x (Node ≥ 22)
- **Linting:** ESLint, Prettier, Stylelint, ember-template-lint, RuboCop (stree formatter)
- **CI:** GitHub Actions via `discourse/.github/.github/workflows/discourse-theme.yml`

### Lint commands

```bash
pnpm lint          # Run all JS/CSS linters
bundle exec rubocop
```

### Running tests

System and migration specs run inside Discourse core (not standalone):

```bash
# From Discourse core directory, with this component installed as a theme:
bundle exec rspec plugins/discourse-easy-footer/spec/
```

JS migration tests use the Discourse QUnit test runner.

## Customization notes

- The PayPal donate button in `custom-footer.hbs` is hardcoded to a specific `hosted_button_id`. Update it directly in the template when the donation account changes.
- The copyright line in the third box (`// lotuselan.net/terms-and-conditions#copy`) is also hardcoded in the template.
- Social link tests are currently commented out in `footer_spec.rb` pending a fix.
- The `PluginOutlet` named `easy-footer-second-box` allows other plugins/themes to inject content into the second column.

## Discourse compatibility

See `.discourse-compatibility` for pinned commit SHAs for older Discourse versions.

## Deployment
Changes pushed to the `main` branch of this GitHub repo are
automatically pulled by my production Discourse site.
DO NOT suggest changes that require server-side Discourse core modifications.
Only suggest changes within the plugin file structure.

## Key Rules
- Keep changes compatible with Discourse's Ember.js version
- Test SCSS changes carefully — they affect the live site immediately after pull