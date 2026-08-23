#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Rescue every PDF off the old Weebly site into ./papers/
#
# RUN THIS BEFORE WEEBLY TAKES THE SITE DOWN. Once it's gone, these files
# are gone with it.
#
#   cd into this folder, then:   bash get-pdfs.sh
#
# It's safe to run more than once; existing files are skipped.
# ---------------------------------------------------------------------------

set -u
BASE="https://www.jeffreyljensen.com/uploads/1/2/1/5/121574335"
mkdir -p papers

# old-filename-on-weebly|new-filename-in-papers/
FILES=(
  "cv_jensen_sept_2024.pdf|cv_jensen.pdf"
  "us_south_manuscript.pdf|us_south_manuscript.pdf"
  "slavery_and_taxation_jop_resubmission.pdf|slavery_and_taxation_jop.pdf"
  "sm_lm_religion_june2021.pdf|sm_lm_religion.pdf"
  "jhpe_final_2021.pdf|jhpe_reconstruction.pdf"
  "duelingpaper_jce_revision_2.pdf|dueling_jce.pdf"
  "sapd_referendums_preprint.pdf|sapd_referendums.pdf"
  "jeh_secession_july2019.pdf|jeh_secession.pdf"
  "defactopower_wp__revision__complete_nonanon.pdf|defacto_power_wp.pdf"
  "us13revisedwithappendix.pdf|us13_states.pdf"
  "2nd_resubmission_manuscript.pdf|democratic_reversals.pdf"
  "jce_investment_pub.pdf|jce_investment.pdf"
  "partisan_media_exposure_preprint_july_2023.pdf|partisan_media_exposure_preprint.pdf"
  "black_disenfranchisement_and_white_redistribution.pdf|black_disenfranchisement.pdf"
  "ipt_syllabus_f20.pdf|ipt_syllabus_f20.pdf"
  "inquality_syllabus_f20.pdf|inequality_syllabus_f20.pdf"
  "syllabus_geps_f19.pdf|syllabus_geps_f19.pdf"
)

ok=0; failed=0
for entry in "${FILES[@]}"; do
  src="${entry%%|*}"
  dst="papers/${entry##*|}"
  if [ -s "$dst" ]; then
    echo "  skip   $dst (already here)"
    ok=$((ok+1))
    continue
  fi
  printf '  fetch  %s ... ' "$dst"
  if curl -fsSL --retry 3 -o "$dst" "$BASE/$src"; then
    echo "ok ($(du -h "$dst" | cut -f1))"
    ok=$((ok+1))
  else
    echo "FAILED"
    rm -f "$dst"
    failed=$((failed+1))
  fi
done

echo
echo "Done: $ok retrieved, $failed failed."
[ "$failed" -gt 0 ] && echo "Any failures are listed above — grab those by hand from the old site."
exit 0
