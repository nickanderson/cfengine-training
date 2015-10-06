default: light dark

presentation: light dark

light: themes/avalanche/.git
		landslide --relative --embed presentation-light.cfg

dark: themes/avalanche/.git
		landslide --relative --embed presentation-dark.cfg

# The PDF that is currently generated is not great
pdf: themes/avalanche/.git
		landslide --relative --embed presentation-pdf.cfg

themes:
	mkdir themes

themes/avalanche/.git: themes
	# Clone the avalanche repo if we don't have it
	if [ -f ./themes/avalanche/.git ] || cd themes && git clone https://github.com/akrabat/avalanche.git; \
	then cd themes/avalanche && git pull; \
	fi
