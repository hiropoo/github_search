# Makefile

.PHONY: init gen-l10n fvm build-runner pub-get

# Flutterプロジェクトの初期設定
init: pub-get fvm gen-l10n build-runner

# Flutterの依存関係を取得
pub-get:
	@echo "Fetching Flutter dependencies..."
	flutter pub get

# Flutterのローカライズを生成
gen-l10n:
	@echo "Generating localization files..."
	flutter gen-l10n

# FVMの設定
fvm:
	@echo "Configuring FVM..."
	fvm use

# build_runnerを実行してコード生成を行う
build-runner:
	@echo "Running build_runner..."
	dart run build_runner watch -d
