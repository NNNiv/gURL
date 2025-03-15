live/templ:
	templ generate --watch --proxy="http://localhost:4000" --open-browser=false -v

live/server:
	air \
	--build.cmd "go build -o tmp/bin/main" --build.bin "tmp/bin/main" --build.delay "100" \
	--build.exclude_dir "node_modules" \
	--build.include_ext "go" \
	--build.stop_on_error "false" \
	--misc.clean_on_exit true

live/tailwind:
	npx @tailwindcss/cli -i ./tailwind.config.css -o ./static/style.css --watch


live/sync_assets:
	air \
	--build.cmd "templ generate --notify-proxy" \
	--build.bin "true" \
	--build.exclude_dir "" \
	--build.include_dir "static" \
	--build.include_ext "js,css"

live: 
	make -j4 live/tailwind live/templ live/server live/sync_assets
