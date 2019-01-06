 #!/bin/sh

	size0=$(stat --printf="%s" /home/fuzzbox/.mutt/perso/inbox)
        size1=$(stat --printf="%s" /home/fuzzbox/.mutt/pro/inbox)
        size2=$(stat --printf="%s" /home/fuzzbox/.mutt/gmail/inbox)
        if [ $size0 = "0" ] && [ $size1 = "0" ] && [ $size2 = "0" ]; then
		exit 0
	else
		play ~/.local/share/sounds/vousavezducourrier.wav
	fi



