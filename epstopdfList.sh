
#!/bin/bash

for f in $@
do
    if [ `echo $f | grep '.eps' ` ]
    then
	echo epstopdf $f
	epstopdf $f
    fi
done
