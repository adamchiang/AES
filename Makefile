# Makefile
# --------------------------------------------------
# Author: Adam Chiang
# E-mail: adam.chiang@utexas.edu
# --------------------------------------------------

.SUFFIXES:	.java .class .txt .out
# --------------------------------------------------
# Define the Java compiler to use
JC	:=	javac

# Define any Java compile-time flags
JFLAGS	:=	-g

# Define the Java source files
JSRCS	:=	AES.java\
			Data.java

# Define the Java class files
JCLAS	:=	*.class

# Define the Java executable files
JEXEC	:=	AES

# --------------------------------------------------
# Define any test files
TEST	:=	$(wildcard test*.txt)

KEY	:=	$(wildcard key*.txt)

OUT	:=	$(wildcard *.enc*)
# --------------------------------------------------
# .PHONY causes the compiler to ignore files
.PHONY:	java turnin clean test1 test2 test3 test4

# --------------------------------------------------
# Automatic variable definitions:
#	$@ the target file name
#	$* the target file name without the file extension
#	$< the first prerequisite file name
#	$^ the file names of all the prerequisites, separated by spaces,
#	   discard duplicates
#	$+ similar to $^, but includes duplicates
#	$? the names of all prerequisites that are newer than the target,
#	   separated by spaces
# --------------------------------------------------

all:	java

# Rules for default execution
# --------------------------------------------------


# Rules for compiling Java files
# --------------------------------------------------
java:	$(JEXEC)

# Java executables depend on the Java source files
$(JEXEC):	$(JSRCS)
	@ $(JC) $(JFLAGS) $^

# Rules for testing
# --------------------------------------------------
test1:	$(JEXEC)
	@ java AES e -length 128 key1.txt test1.txt
	@ java AES d -length 128 key1.txt test1.txt.enc
# @ diff -si test1.txt test1.txt.enc.dec

test2:	$(JEXEC)
	@ java AES e -length 192 key2.txt test2.txt
	@ java AES d -length 192 key2.txt test2.txt.enc
# @ diff -si test2.txt test2.txt.enc.dec

test3:	$(JEXEC)
	@ java AES e -length 256 key3.txt test3.txt
	@ java AES d -length 256 key3.txt test3.txt.enc
# @ diff -si test3.txt test3.txt.enc.dec

test4:	$(JEXEC)
	@ java AES e -length 256 -mode cbc key4.txt test4.txt
	@ java AES d -length 256 -mode cbc key4.txt test4.txt.enc
# @ diff -si test4.txt test4.txt.enc.dec

# Command to create archive for submission
# --------------------------------------------------
turnin:
	tar -acf acc2729_amm6364_program4.zip $(JSRCS) $(TEST) $(KEY) $(OUT) Makefile README.txt

# Command to clean directory
# --------------------------------------------------
clean:
	@ $(RM) $(JCLAS) $(JEXEC) $(OUT)
