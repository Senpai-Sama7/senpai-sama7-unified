# Phase 1: Consolidation Checklist

**Timeline:** Jan 1-5, 2025 (5 days)  
**Goal:** Migrate 5 Tier 1 repos into single monorepo  
**Expected Duration:** 6-8 hours of active work  

---

## 🎯 High-Level Plan

```
[Clone 5 repos] → [Run tests] → [Create monorepo files] → [Commit] → [Push]
    (2 hrs)      (2 hrs)      (1 hr)                 (30 mins) (30 mins)
```

---

## ✅ Pre-Execution Checklist (Before you start)

- [ ] You have `git` installed (`git --version`)
- [ ] You have `npm` or `python` installed (depending on repos)
- [ ] SSH keys configured for GitHub (`ssh -T git@github.com`)
- [ ] You're in an empty or existing `senpai-sama7-unified` directory
- [ ] Disk space available: ~2-3 GB (for 5 repos + node_modules)
- [ ] Download link to PHASE_1_EXECUTION.sh ready

---

## 🚀 Execution Steps

### Step 1: Clone the Monorepo (1 min)

```bash
git clone https://github.com/Senpai-Sama7/senpai-sama7-unified.git
cd senpai-sama7-unified
```

### Step 2: Download & Run Phase 1 Script (5-10 mins)

```bash
# Make script executable
chmod +x PHASE_1_EXECUTION.sh

# Run it
./PHASE_1_EXECUTION.sh
```

**What it does:**
1. ✅ Creates directory structure (core/, apps/, data/, etc.)
2. ✅ Clones all 5 Tier 1 repos as subdirectories
3. ✅ Runs `npm test` / `pytest` on each repo
4. ✅ Creates Makefile for convenient commands
5. ✅ Creates docker-compose.yml for local development
6. ✅ Shows you the final structure

**Expected output:**
```
[2/10] Cloning prometheus-stack (crown jewel)...
[3/10] Cloning agent-42-production (agent orchestration)...
[4/10] Cloning JobFit-AI (application layer)...
[5/10] Cloning DocuMancer (data pipeline)...
[6/10] Cloning Vibe-Wiki (UI components + docs)...
[7/10] MCP Framework... (PENDING: audit decision)
[8/10] Running tests on all modules...
[9/10] Creating monorepo root files...
[10/10] Preparing for commit...
```

### Step 3: Review Consolidated Structure

After script finishes:

```bash
# See what was created
git status

# See directory tree (if tree is installed)
tree -L 2 -I 'node_modules|__pycache__'

# Or use find
find . -maxdepth 2 -type d | grep -v '.git' | sort
```

**Expected structure:**
```
senpai-sama7-unified/
├── core/
│   ├── prometheus/             (from prometheus-stack)
│   ├── agent-orchestration/    (from agent-42-production)
│   ├── mcp/                    (TODO: add after audit)
│   └── shared/                 (future: shared utilities)
├── apps/
│   ├── jobfit-ai/              (from JobFit-AI)
│   └── ui-library/             (from Vibe-Wiki)
├── data/
│   └── document-processing/    (from DocuMancer)
├── docs/                       (documentation)
├── tests/                      (integration tests)
├── scripts/                    (helper scripts)
├── kubernetes/                 (K8s manifests - Phase 4)
├── Makefile                    (NEW: common tasks)
├── docker-compose.yml          (NEW: local dev)
├── README.md                   (NEW: master README)
└── .github/
    └── workflows/              (CI/CD - Phase 2)
```

### Step 4: Verify Tests Still Pass

Manually run tests to confirm everything works:

```bash
# Test prometheus (crown jewel)
cd core/prometheus
npm test        # or: pytest tests/ -v
cd ../..

# Test agent orchestration
cd core/agent-orchestration
npm test
cd ../..

# Test JobFit-AI
cd apps/jobfit-ai
npm test
cd ../..

# Test DocuMancer
cd data/document-processing
npm test
cd ../..

# Test Vibe-Wiki
cd apps/ui-library
npm test
cd ../..
```

**Success criteria:**
- [ ] ✅ prometheus-stack: 95.3% coverage maintained
- [ ] ✅ agent-42-production: All tests pass
- [ ] ✅ JobFit-AI: All tests pass
- [ ] ✅ DocuMancer: All tests pass
- [ ] ✅ Vibe-Wiki: All tests pass

### Step 5: Stage & Commit

```bash
# See all changes
git status

# Stage everything
git add -A

# Verify staging
git status --short

# Commit with clear message
git commit -m "Phase 1: Consolidate 5 Tier 1 repos into monorepo

- core/prometheus-stack (95.3% coverage, production-ready)
- core/agent-42-production (multi-agent orchestration)
- apps/jobfit-ai (job matching application)
- data/document-processing (DocuMancer data pipeline)
- apps/ui-library (Vibe-Wiki components + docs)

All tests passing. Monorepo structure in place.
Ready for Phase 2 (CI/CD automation)."
```

### Step 6: Push to GitHub

```bash
# Push to main
git push origin main

# Verify on GitHub
open https://github.com/Senpai-Sama7/senpai-sama7-unified
# or: echo "https://github.com/Senpai-Sama7/senpai-sama7-unified"
```

---

## 📊 Post-Execution Verification

After pushing, verify on GitHub:

- [ ] ✅ Main branch shows all 5 repos as subdirectories
- [ ] ✅ Makefile present in root
- [ ] ✅ docker-compose.yml present in root
- [ ] ✅ Last commit message mentions Phase 1 consolidation
- [ ] ✅ No merge conflicts
- [ ] ✅ GitHub shows correct file count

---

## 🚨 Troubleshooting

### Issue: "git clone" fails with network error

**Solution:**
```bash
# Check SSH connection
ssh -T git@github.com

# If SSH fails, try HTTPS
# Edit script to use: https://github.com/Senpai-Sama7/[repo].git
# Instead of: git@github.com:Senpai-Sama7/[repo].git
```

### Issue: Tests fail after cloning

**Solution:**
```bash
# Each repo might need dependencies installed
cd core/prometheus
npm install  # or: pip install -r requirements.txt
npm test
cd ../..
```

### Issue: Disk space error

**Solution:**
```bash
# Check available space
df -h

# If low, clean up node_modules in other projects
# Or increase AWS instance size
```

### Issue: Script permissions error

**Solution:**
```bash
# Make script executable
chmod +x PHASE_1_EXECUTION.sh

# Run with bash explicitly
bash PHASE_1_EXECUTION.sh
```

---

## 📈 Expected Results by End of Phase 1

- [ ] ✅ **senpai-sama7-unified** repo has all 5 Tier 1 repos as subdirectories
- [ ] ✅ **All tests passing** (no broken functionality)
- [ ] ✅ **Makefile works** (can run `make test`, `make install`, etc.)
- [ ] ✅ **docker-compose.yml valid** (can run `docker-compose up`)
- [ ] ✅ **Single source of truth** (no more 59 scattered repos)
- [ ] ✅ **55 Tier 3 repos ready for archival** (will do after Phase 1)
- [ ] ✅ **Phase 2 blocked on:** MCP framework audit decision

---

## 📝 Next: Phase 2 (Jan 6-12)

Once Phase 1 is complete:

1. **Add MCP framework** (core/mcp/) once audit is done
2. **Set up GitHub Actions CI/CD** (test.yml, lint.yml, security.yml)
3. **Aggregate requirements** (single requirements.txt)
4. **Verify all workflows passing**

**See:** `monorepo-setup-plan.md` Phase 2 section

---

## ✉️ Questions?

If stuck:

1. Check this checklist again
2. Review **PHASE_1_EXECUTION.sh** for what each step does
3. Check GitHub issues for similar problems
4. Run with `-v` for verbose output: `bash -x PHASE_1_EXECUTION.sh`

---

**You've got this. Phase 1 is straightforward: clone, test, commit, push.**

**By Jan 5: 1 monorepo. 59 repos consolidated. Tests passing.**

🚀
