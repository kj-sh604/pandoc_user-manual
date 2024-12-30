compile:
	@./utils/build.sh

clean:
	@if [ -d "public" ]; then \
		rm -r public/; \
		echo "rm'd the 'public' directory."; \
	else \
		echo "no 'public' directory found, skipping cleanup."; \
	fi
	@if [ -d "output" ]; then \
		rm -r output/; \
		echo "rm'd the 'output' directory."; \
	else \
		echo "no 'output' directory found, skipping cleanup."; \
	fi
