
# Quickly change from /projects directory to /arm/projectscratch and vice-versa
# Example:
# $> pwd
# /projects/pd/zeus_pj02519/val
# $> cdscratch
# $> pwd
# /arm/projectscratch/pd/zeus_pj02519/val
# $> cdprojects
# $> pwd
# /projects/pd/zeus_pj02519/val
alias cdscratch='cd ${PWD/\/projects/\/arm\/projectscratch}'
alias cdprojects='cd ${PWD/\/arm\/projectscratch/\/projects}'

