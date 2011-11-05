#SDL_HOME = /media/sda3/data/projects/sdl_lib
#OPTIONS  = -ovm -linedebug -incdir $(SDL_HOME)/src -gui
OPTIONS = -incdir $(OVM_HOME)/src \
          -incdir $(SDL_HOME)/src \
          -linedebug  

include Makefile.ius

#TESTS = fsm bitstuff_transmission basic
TESTS =fsm

all: $(TESTS)

$(TESTS):
	@echo "Running test $@_test ..." ;\
	cd  $@_test; rm -rf INCA_libs; $(IUS) $@_test.sv -gui


