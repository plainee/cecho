#!/bin/sh

# source me in your script or .bashrc/.zshrc if wanna use cecho
# source '/path/to/cecho.sh'

# for macro
export CECHO_IS_IMPORTED=1

cecho()
{
	#FOREGROUND
	FG_BLACK="\e[30m"
	FG_RED="\e[31m"
	FG_GREEN="\e[32m"
	FG_YELLOW="\e[33m"
	FG_BLUE="\e[34m"
	FG_PURPLE="\e[35m"
	FG_CYAN="\e[36m"
	FG_WHITE="\e[37m"

	#BACKGROUND
	BG_BLACK="\e[40m"
	BG_RED="\e[41m"
	BG_GREEN="\e[42m"
	BG_YELLOW="\e[43m"
	BG_BLUE="\e[44m"
	BG_PURPLE="\e[45m"
	BG_CYAN="\e[46m"
	BG_WHITE="\e[47m"

	#ACTION
	DONE="\e[0m"
	HIGHLIGHT="\e[1m"
	UNDERLINE="\e[4m"
	BLINK="\e[5m"
	REVERSE="\e[7m"
	INVISIBLE="\e[8m"

	msg=$DONE
	help_info='cecho \
	-r -hl -re -t -t -t -t "the page is generated by" -B -bl "cecho" -d -r -hl -re -t -t -t -t -d -n \
	-hl Usage: -d -n \
	-t "a light and simple wrapper of echo, with colour flags." -d -n -n\
	-hl Syntax: -d -n \
	-t -g -hl cecho -d -B -y -color1 -B -b message1 -w -B "[ -color2 message2 ... ]" -r -B "[ -done ]" -d -n \
	-t -g -hl cecho -d -B -y -fg_color -B -p -bg_color -B -c -action -B -b message -B -w "[...]" -B -r "[ -done ]" -d -n -n \
	-hl "ForeGround color flag:" -d -n \
	-t -r "-r | -red" -t -g "-g | -green" -t -y "-y | -yellow" -t -bk -bw "-bk | -black" -d "(here with white bg)" -d -n \
	-t -b "-b | -blue" -t -p "-p | -purple" -t -c "-c | -cyan" -t -w "-w | -gr | -white | -gray" -d -n -n\
	-hl "BackGround color flag:" -d -n \
	-t -br "-br | -b_red" -t -bg "-bg | -b_green" -t -by "-by | -b_yellow" -t -bbk "-bbk | -b_black" -d -n \
	-t -bb "-bb | -b_blue" -t -bp "-bp | -b_purple" -t -bc "-bc | -b_cyan" -t -bw "-bw | -bgr | -b_white | -b_gray" -d -n -n \
	-hl "Action flag:" -d -n \
	-t "-d  | -done" -t -hl "-hl | -highlight" -d -t -ul "-ul | -underline" -d -t -re "-re | -reverse" -d -n \
	-t -bl "-bl | -blink" -d -t "[ there is invisible here ]" -t "-->" -iv "-iv | -invisible" -d "<--" -n -n \
	-hl "Escaped character:" -d -n \
	-t "-B | -blank" -t "-t | -tab" -t "-n | -newline" -d -n \
	-g -hl -re -t -t -t -t "the src of above (as an example)" -t -t -t -d'

	# TODO:for debugging
	help_info2='cecho
	-r -hl -re -t -t -t -t "the page is generated by" -B -bl "cecho" -d -r -hl -re -t -t -t -t -d -n
	-hl Usage: -d -n
	-t "a light and simple wrapper of echo, with colour flags." -d -n -n
	-hl Syntax: -d -n
	-t -g -hl cecho -d -B -y -color1 -B -b message1 -w -B "[ -color2 message2 ... ]" -r -B "[ -done ]" -d -n
	-t -g -hl cecho -d -B -y -fg_color -B -p -bg_color -B -c -action -B -b message -B -w "[...]" -B -r "[ -done ]" -d -n -n
	-hl "ForeGround color flag:" -d -n
	-t -r "-r | -red" -t -g "-g | -green" -t -y "-y | -yellow" -t -bk -bw "-bk | -black" -d "(here with white bg)" -d -n
	-t -b "-b | -blue" -t -p "-p | -purple" -t -c "-c | -cyan" -t -w "-w | -gr | -white | -gray" -d -n -n
	-hl "BackGround color flag:" -d -n
	-t -br "-br | -b_red" -t -bg "-bg | -b_green" -t -by "-by | -b_yellow" -t -bbk "-bbk | -b_black" -d -n
	-t -bb "-bb | -b_blue" -t -bp "-bp | -b_purple" -t -bc "-bc | -b_cyan" -t -bw "-bw | -bgr | -b_white | -b_gray" -d -n -n
	-hl "Action flag:" -d -n
	-t "-d  | -done" -t -hl "-hl | -highlight" -d -t -ul "-ul | -underline" -d -t -re "-re | -reverse" -d -n
	-t -bl "-bl | -blink" -d -t "[ there is invisible here ]" -t "-->" -iv "-iv | -invisible" -d "<--" -n -n
	-hl "Escaped character:" -d -n
	-t "-B | -blank" -t "-t | -tab" -t "-n | -newline" -d -n
	-g -hl -re -t -t -t -t "the src of above (as an example)" -t -t -t -d'

	IS_NEED_BLANK=

	while (($#!=0))
	do

	# set single blank

	if [ -z $IS_NEED_BLANK ]
	then
		INTL_SINGLE_BLANK=""
	else
		INTL_SINGLE_BLANK=" "
	fi

	IS_NEED_BLANK=

	case $1 in

		# escape character

		-B | -blank		)	msg+=" "; ;;
		#-t | -tab		)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo "\t" || echo $INTL_SINGLE_BLANK`;	;;
		-t | -tab		)	msg+="\t";	;;
		#-n | -newline	)	[ -z $CECHO_IS_INACTIVE ] && msg+="\n" || msg+=$INTL_SINGLE_BLANK;	;;
		-n | -newline	)	msg+="\n"	;;

		# foreground color

		-bk| -black		)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $FG_BLACK	|| echo $INTL_SINGLE_BLANK`;   ;;
		-r | -red		)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $FG_RED		|| echo $INTL_SINGLE_BLANK`;   ;;
		-g | -green		)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $FG_GREEN	|| echo $INTL_SINGLE_BLANK`;   ;;
		-y | -yellow	)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $FG_YELLOW	|| echo $INTL_SINGLE_BLANK`;   ;;
		-b | -blue		)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $FG_BLUE	|| echo $INTL_SINGLE_BLANK`;   ;;
		-p | -purple	)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $FG_PURPLE	|| echo $INTL_SINGLE_BLANK`;   ;;
		-c | -cyan		)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $FG_CYAN	|| echo $INTL_SINGLE_BLANK`;   ;;
		-w | -white		)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $FG_WHITE	|| echo $INTL_SINGLE_BLANK`;   ;;
		-gr| -gray		)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $FG_WHITE	|| echo $INTL_SINGLE_BLANK`;   ;;

		# background color

		-bbk| -b_black	)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $BG_BLACK	|| echo $INTL_SINGLE_BLANK`;   ;;
		-br | -b_red	)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $BG_RED		|| echo $INTL_SINGLE_BLANK`;   ;;
		-bg | -b_green	)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $BG_GREEN	|| echo $INTL_SINGLE_BLANK`;   ;;
		-by | -b_yellow	)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $BG_YELLOW	|| echo $INTL_SINGLE_BLANK`;   ;;
		-bb | -b_blue	)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $BG_BLUE	|| echo $INTL_SINGLE_BLANK`;   ;;
		-bp | -b_purple	)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $BG_PURPLE	|| echo $INTL_SINGLE_BLANK`;   ;;
		-bc | -b_cyan	)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $BG_CYAN	|| echo $INTL_SINGLE_BLANK`;   ;;
		-bw | -b_white	)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $BG_WHITE   || echo $INTL_SINGLE_BLANK`;   ;;
		-bgr| -b_gray	)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $BG_WHITE   || echo $INTL_SINGLE_BLANK`;   ;;

		# action, some can be overlaid

		-d | -done		)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $DONE		|| echo $INTL_SINGLE_BLANK`;   ;;
		-hl| -highlight	)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $HIGHLIGHT	|| echo $INTL_SINGLE_BLANK`;   ;;
		-ul| -underline	)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $UNDERLINE	|| echo $INTL_SINGLE_BLANK`;   ;;
		-bl| -blink		)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $BLINK		|| echo $INTL_SINGLE_BLANK`;   ;;
		-re| -reverse	)	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $REVERSE	|| echo $INTL_SINGLE_BLANK`;   ;;
		-iv| -invisible )	msg+=`[ -z $CECHO_IS_INACTIVE ] && echo $INVISIBLE	|| echo $INTL_SINGLE_BLANK`;   ;;

		# functional

		-h|-help|--help	)
			eval $help_info
			cecho $help_info
			return 0
		;;

		# TODO:for debugging
		-h2|-help2|--helpi2	)
			eval $help_info2
			cecho $help_info2
			return 0
		;;

		# string

		*)
			msg=$msg$1
			IS_NEED_BLANK=1
		;;
	esac
	shift
	done

	# clear

	msg+=$DONE"\n"	

	# print

	echo -ne $msg
}

