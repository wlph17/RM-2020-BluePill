# Space handling by replacing it with other characters temporarily
s+ = $(subst $() $(),+++,$1)
+s = $(subst +++,$() $(),$1)

normalize = $(subst \,/,$1)