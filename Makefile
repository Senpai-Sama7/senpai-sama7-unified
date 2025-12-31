.PHONY: help install test lint clean build deploy

help:
	@echo "senpai-sama7-unified - Monorepo Commands"
	@echo ""
	@echo "Commands:"
	@echo "  make install    Install dependencies for all modules"
	@echo "  make test       Run tests for all modules"
	@echo "  make lint       Run linting for all modules"
	@echo "  make clean      Clean build artifacts"
	@echo "  make build      Build all modules"
	@echo "  make deploy     Deploy to production"

install:
	@echo "Installing dependencies..."
	cd core/prometheus && npm install && cd ../..
	cd core/agent-orchestration && npm install && cd ../..
	cd apps/jobfit-ai && npm install && cd ../..
	cd data/document-processing && npm install && cd ../..
	cd apps/ui-library && npm install && cd ../..
	@echo "✓ All dependencies installed"

test:
	@echo "Running tests..."
	cd core/prometheus && npm test && cd ../..
	cd core/agent-orchestration && npm test && cd ../..
	cd apps/jobfit-ai && npm test && cd ../..
	cd data/document-processing && npm test && cd ../..
	cd apps/ui-library && npm test && cd ../..
	@echo "✓ All tests passed"

lint:
	@echo "Running linters..."
	cd core/prometheus && npm run lint && cd ../..
	cd core/agent-orchestration && npm run lint && cd ../..
	cd apps/jobfit-ai && npm run lint && cd ../..
	cd data/document-processing && npm run lint && cd ../..
	cd apps/ui-library && npm run lint && cd ../..
	@echo "✓ Linting complete"

clean:
	@echo "Cleaning build artifacts..."
	find . -type d -name node_modules -exec rm -rf {} +
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type d -name .pytest_cache -exec rm -rf {} +
	@echo "✓ Clean complete"

build:
	@echo "Building all modules..."
	cd core/prometheus && npm run build && cd ../..
	cd core/agent-orchestration && npm run build && cd ../..
	cd apps/jobfit-ai && npm run build && cd ../..
	cd apps/ui-library && npm run build && cd ../..
	@echo "✓ Build complete"

deploy:
	@echo "Deploying to production..."
	@echo "See kubernetes/ and scripts/ for deployment automation"
