#!/bin/sh

cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<testdefinition version="1.0">
    <suite name="telepathy-gabble-tests">
        <description>Telepathy Gabble tests</description>
        <set name="telepathy-gabble-C-tests">
EOF

for testcase in $(cat tests/gabble-C-tests.list)
do
    testcase_name=$(echo $testcase|sed 's/\//_/')
    attributes="name=\"$testcase_name\""
    insignificant=`grep "^$testcase" tests/INSIGNIFICANT || true`
    if test -n "$insignificant"
    then
        continue
        attributes="$attributes insignificant=\"true\""
    fi
    cat <<EOF
        <case $attributes>
            <step>/opt/tests/telepathy-gabble/$testcase</step>
        </case>
EOF
done

cat <<EOF
        </set>
        <set name="telepathy-gabble-twisted-tests">
EOF

for testcase in $(cat tests/twisted/gabble-twisted-tests.list)
do
    testcase_name=$(echo $testcase|sed 's/\//_/')
    attributes="name=\"$testcase_name\""
    insignificant=`grep "^$testcase" tests/INSIGNIFICANT || true`
    if test -n "$insignificant"
    then
        continue
        attributes="$attributes insignificant=\"true\""
    fi
    cat <<EOF
        <case $attributes>
            <step>/opt/tests/telepathy-gabble/twisted/run-test.sh $testcase</step>
        </case>
EOF
done

cat <<EOF
        </set>
    </suite>
</testdefinition>
EOF

