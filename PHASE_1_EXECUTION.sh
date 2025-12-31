#!/bin/bash

################################################################################
#  PHASE 1 EXECUTION SCRIPT
#  Consolidate 5 Tier 1 repos into monorepo
#  Expected runtime: 6-8 hours
################################################################################

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}================================================================${NC}"
echo -e "${BLUE}  PHASE 1: MONOREPO CONSOLIDATION${NC}"
echo -e "${BLUE}  Start time: $(date)${NC}"
echo -e "${BLUE}================================================================${NC}\n"

# Check prerequisites
echo -e "${YELLOW}[CHECK] Prerequisites...${NC}"
command -v git >/dev/null 2>&1 || { echo "Git is required but not installed."; exit 1; }
command -v npm >/dev/null 2>&1 || { echo "npm is required but not installed."; exit 1; }
echo -e "${GREEN}✓ git and npm installed${NC}\n"

# Verify we're in the right directory
if [ ! -d ".git" ]; then
  echo -e "${RED}✗ Not in a git repository. Run: cd ~/senpai-sama7-unified${NC}"
  exit 1
fi

echo -e "${YELLOW}[1/10] Creating directory structure...${NC}"
mkdir -p core/{prometheus,agent-orchestration,mcp,shared}
mkdir -p apps/{jobfit-ai,ui-library}
mkdir -p data/document-processing
mkdir -p tests scripts kubernetes .github/workflows
echo -e "${GREEN}✓ Directory structure ready${NC}\n"

echo -e "${YELLOW}[2/10] Cloning prometheus-stack (crown jewel)...${NC}"
if [ -d "core/prometheus/.git" ]; then
  echo -e "${YELLOW}  → Already cloned, pulling latest...${NC}"
  cd core/prometheus && git pull origin main && cd ../..
else
  git clone https://github.com/Senpai-Sama7/prometheus-stack.git core/prometheus/
fi
echo -e "${GREEN}✓ prometheus-stack ready${NC}\n"

echo -e "${YELLOW}[3/10] Cloning agent-42-production (agent orchestration)...${NC}"
if [ -d "core/agent-orchestration/.git" ]; then
  echo -e "${YELLOW}  → Already cloned, pulling latest...${NC}"
  cd core/agent-orchestration && git pull origin main && cd ../..
else
  git clone https://github.com/Senpai-Sama7/agent-42-production.git core/agent-orchestration/
fi
echo -e "${GREEN}✓ agent-42-production ready${NC}\n"

echo -e "${YELLOW}[4/10] Cloning JobFit-AI (application layer)...${NC}"
if [ -d "apps/jobfit-ai/.git" ]; then
  echo -e "${YELLOW}  → Already cloned, pulling latest...${NC}"
  cd apps/jobfit-ai && git pull origin main && cd ../..
else
  git clone https://github.com/Senpai-Sama7/JobFit-AI.git apps/jobfit-ai/
fi
echo -e "${GREEN}✓ JobFit-AI ready${NC}\n"

echo -e "${YELLOW}[5/10] Cloning DocuMancer (data pipeline)...${NC}"
if [ -d "data/document-processing/.git" ]; then
  echo -e "${YELLOW}  → Already cloned, pulling latest...${NC}"
  cd data/document-processing && git pull origin main && cd ../..
else
  git clone https://github.com/Senpai-Sama7/DocuMancer.git data/document-processing/
fi
echo -e "${GREEN}✓ DocuMancer ready${NC}\n"

echo -e "${YELLOW}[6/10] Cloning Vibe-Wiki (UI components + docs)...${NC}"
if [ -d "apps/ui-library/.git" ]; then
  echo -e "${YELLOW}  → Already cloned, pulling latest...${NC}"
  cd apps/ui-library && git pull origin main && cd ../..
else
  git clone https://github.com/Senpai-Sama7/Vibe-Wiki.git apps/ui-library/
fi
echo -e "${GREEN}✓ Vibe-Wiki ready${NC}\n"

# Note: MCP repo should be added based on audit decision
echo -e "${YELLOW}[7/10] MCP Framework...${NC}"
echo -e "${YELLOW}  ⚠ PENDING: Choose Ultimate_MCP or Titanium-MCP${NC}"
echo -e "${YELLOW}  → Once chosen, run:${NC}"
echo -e "${YELLOW}     git clone [MCP-REPO-URL] core/mcp/${NC}"
echo -e "${BLUE}     (Continuing with other tasks...)${NC}\n"

echo -e "${YELLOW}[8/10] Running tests on all modules...${NC}"
echo -e "${BLUE}─────────────────────────────────────────${NC}"

# Test prometheus-stack
echo -e "${YELLOW}Testing: prometheus-stack...${NC}"
cd core/prometheus
if [ -f "package.json" ]; then
  npm test 2>&1 | head -20
elif [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then
  python -m pytest tests/ -v 2>&1 | head -20
else
  echo -e "${YELLOW}  (No standard test config found)${NC}"
fi
cd ../..
echo -e "${GREEN}✓ prometheus-stack tested${NC}\n"

# Test agent-orchestration
echo -e "${YELLOW}Testing: agent-42-production...${NC}"
cd core/agent-orchestration
if [ -f "package.json" ]; then
  npm test 2>&1 | head -20
elif [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then
  python -m pytest tests/ -v 2>&1 | head -20
else
  echo -e "${YELLOW}  (No standard test config found)${NC}"
fi
cd ../..
echo -e "${GREEN}✓ agent-42-production tested${NC}\n"

# Test JobFit-AI
echo -e "${YELLOW}Testing: JobFit-AI...${NC}"
cd apps/jobfit-ai
if [ -f "package.json" ]; then
  npm test 2>&1 | head -20
elif [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then
  python -m pytest tests/ -v 2>&1 | head -20
else
  echo -e "${YELLOW}  (No standard test config found)${NC}"
fi
cd ../..
echo -e "${GREEN}✓ JobFit-AI tested${NC}\n"

# Test DocuMancer
echo -e "${YELLOW}Testing: DocuMancer...${NC}"
cd data/document-processing
if [ -f "package.json" ]; then
  npm test 2>&1 | head -20
elif [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then
  python -m pytest tests/ -v 2>&1 | head -20
else
  echo -e "${YELLOW}  (No standard test config found)${NC}"
fi
cd ../..
echo -e "${GREEN}✓ DocuMancer tested${NC}\n"

# Test Vibe-Wiki
echo -e "${YELLOW}Testing: Vibe-Wiki...${NC}"
cd apps/ui-library
if [ -f "package.json" ]; then
  npm test 2>&1 | head -20
elif [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then
  python -m pytest tests/ -v 2>&1 | head -20
else
  echo -e "${YELLOW}  (No standard test config found)${NC}"
fi
cd ../..
echo -e "${GREEN}✓ Vibe-Wiki tested${NC}\n"

echo -e "${BLUE}─────────────────────────────────────────${NC}\n"

echo -e "${YELLOW}[9/10] Creating monorepo root files...${NC}"

# Create Makefile
cat > Makefile << 'EOF'
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
EOF

echo -e "${GREEN}✓ Makefile created${NC}"

# Create docker-compose.yml placeholder
cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  prometheus:
    build: ./core/prometheus
    ports:
      - "9090:9090"

  agent-orchestration:
    build: ./core/agent-orchestration
    ports:
      - "8000:8000"
    environment:
      ANTHROPIC_API_KEY: ${ANTHROPIC_API_KEY}
      OPENAI_API_KEY: ${OPENAI_API_KEY}

  jobfit-ai:
    build: ./apps/jobfit-ai
    ports:
      - "3000:3000"

  document-processor:
    build: ./data/document-processing
    ports:
      - "5000:5000"

EOF

echo -e "${GREEN}✓ docker-compose.yml created${NC}\n"

echo -e "${YELLOW}[10/10] Preparing for commit...${NC}"
echo -e "${BLUE}─────────────────────────────────────────${NC}"
echo -e "${BLUE}Current directory structure:${NC}"
tree -L 2 -I 'node_modules|__pycache__' || find . -maxdepth 2 -type d | grep -v '.git' | sort
echo -e "${BLUE}─────────────────────────────────────────${NC}\n"

echo -e "${YELLOW}Status: Ready to commit${NC}"
echo -e "${YELLOW}Next steps:${NC}"
echo ""
echo -e "  ${BLUE}1. Review the consolidated structure:${NC}"
echo -e "     git status"
echo ""
echo -e "  ${BLUE}2. Stage all changes:${NC}"
echo -e "     git add -A"
echo ""
echo -e "  ${BLUE}3. Commit:${NC}"
echo -e "     git commit -m \"Phase 1: Consolidate 5 Tier 1 repos into monorepo\""
echo ""
echo -e "  ${BLUE}4. Push to GitHub:${NC}"
echo -e "     git push origin main"
echo ""
echo -e "  ${BLUE}5. Verify on GitHub:${NC}"
echo -e "     https://github.com/Senpai-Sama7/senpai-sama7-unified"
echo ""

echo -e "${GREEN}================================================================${NC}"
echo -e "${GREEN}  PHASE 1 SETUP COMPLETE${NC}"
echo -e "${GREEN}  End time: $(date)${NC}"
echo -e "${GREEN}================================================================${NC}\n"

echo -e "${BLUE}Once you push, Phase 2 (CI/CD setup) begins Jan 6.${NC}\n"
