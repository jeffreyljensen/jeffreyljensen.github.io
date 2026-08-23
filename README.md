# jeffreyljensen.com — new static site

A plain HTML/CSS rebuild of the Weebly site. No build step, no framework, no
dependencies. Editing it means opening an `.html` file in any text editor.

```
index.html      About (front page)
research.html   Publications and working papers
teaching.html   Courses and syllabi
404.html        Shown for bad URLs
style.css       All styling — colors, fonts, spacing live at the top
get-pdfs.sh     Downloads your PDFs off the old Weebly site
papers/         Where those PDFs land (created by the script)
CNAME           Tells GitHub Pages your domain
robots.txt      For search engines
sitemap.xml     For search engines
```

---

## Step 0 — Rescue your PDFs (do this first, while Weebly is still up)

Every paper, the CV, and all three syllabi currently live on Weebly's servers.
When the site goes, they go. In a terminal, from inside this folder:

```bash
bash get-pdfs.sh
```

That pulls all 17 files into `papers/`. The site's links already point there.
Run it before anything else — the rest can wait, this can't.

---

## Step 1 — Two things to check before you touch DNS

**Where is the domain actually registered?** If you bought `jeffreyljensen.com`
through Weebly/Square, the registration is a separate product from the site
hosting, but you want to be certain you can still log in and edit DNS records
after the site is switched off. Log into the registrar now and confirm. If it
*is* with Weebly/Square and you'd rather not depend on them, transfer the domain
to a normal registrar (Cloudflare and Porkbun are the usual recommendations) —
transfers take a few days, so start early.

**Your email address.** `index.html` lists `jeffrey.jensen@nyu.edu` — the old
site had it obfuscated so it couldn't be read directly. Check that line and fix
it if it's wrong.

---

## Step 2 — Put it on GitHub Pages

1. Make a free account at [github.com](https://github.com) if you don't have one.
2. Create a new **public** repository named exactly `<your-username>.github.io`
   — for example `jeffreyljensen.github.io`. Don't add a README when prompted.
3. On the empty repo's page, click **uploading an existing file**, then drag in
   everything from this folder, `papers/` included. Commit.
4. Wait a minute, then visit `https://<your-username>.github.io`. The site is
   live. At this point it works even if the domain isn't sorted yet.

<details>
<summary>If you'd rather use the command line</summary>

```bash
git init
git add .
git commit -m "New site"
git branch -M main
git remote add origin https://github.com/<your-username>/<your-username>.github.io.git
git push -u origin main
```
</details>

---

## Step 3 — Point your domain at it

In your registrar's DNS settings, for `jeffreyljensen.com`:

| Type  | Name  | Value |
|-------|-------|-------|
| A     | `@`   | `185.199.108.153` |
| A     | `@`   | `185.199.109.153` |
| A     | `@`   | `185.199.110.153` |
| A     | `@`   | `185.199.111.153` |
| AAAA  | `@`   | `2606:50c0:8000::153` |
| AAAA  | `@`   | `2606:50c0:8001::153` |
| AAAA  | `@`   | `2606:50c0:8002::153` |
| AAAA  | `@`   | `2606:50c0:8003::153` |
| CNAME | `www` | `<your-username>.github.io` |

Delete any existing A/CNAME records for `@` and `www` that point at Weebly.

Then in the repo: **Settings → Pages**, enter `www.jeffreyljensen.com` as the
custom domain, and tick **Enforce HTTPS** once it becomes available (the
certificate takes up to an hour). DNS changes can take a few hours to spread.

---

## Editing it later

- **New paper?** Copy an existing `<li>` block in `research.html`, change the
  text, drop the PDF into `papers/`, commit.
- **New CV?** Replace `papers/cv_jensen.pdf` with the new file, same name. No
  other change needed.
- **Colors or fonts?** The variables at the top of `style.css` control
  everything, in both light and dark mode.

Changes go live about a minute after you commit them.
