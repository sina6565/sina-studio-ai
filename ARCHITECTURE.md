# Sina Studio AI — Core Architecture

## System Flow

```
User Request
    ↓
Intent Analysis
    ↓
Planner (Task Decomposition)
    ↓
Orchestrator (Central Coordination)
    ├── Resource Registry (Provider Selection)
    ├── Agent Interface (Task Execution)
    ├── Job Queue (Parallel Execution)
    ├── Capability Router (Domain Routing)
    └── Docker Sandbox (Isolated Execution)
        ├── Build
        ├── Run
        ├── Test
        └── Auto-Fix
    ↓
Quality Control (Validation)
    ↓
Project Engine (Output Generation)
    ├── Web Target
    ├── App Target
    └── Game Target
    ↓
Real Output
```

## Core Components

### 1. Orchestrator
Central coordination hub that:
- Receives user requests
- Analyzes intent
- Creates execution plans
- Selects resources and agents
- Manages job lifecycle
- Tracks execution state
- Returns structured results

### 2. Resource Registry
Provider-agnostic resource management:
- Free resources
- Open Source / Open Weight resources (with license metadata)
- Premium resources
- Sina Exclusive resources
- Support for any resource type without core modification

### 3. Agent System
Modular, provider-agnostic agent framework:
- Creative Agent
- Coding Agent
- Media Agent
- Game Agent
- Product Agent
- Future agents extensible without core changes

### 4. Job Queue
Parallel execution support:
- Job queuing
- Multi-worker execution
- Job state management
- Scalable from 1 to 10,000+ users

### 5. Docker Sandbox
Isolated execution environment:
- Filesystem isolation
- Network control
- Resource limits (CPU/RAM/processes)
- Per-job isolation
- Build/Run/Test/Auto-Fix
- Artifact collection
- No secret leakage

### 6. Intent & Planning
Task decomposition:
- Intent classification
- Plan generation
- Job creation
- Extensible for new domains

### 7. Quality Control
Validation and auto-fix:
- Output validation
- Failure detection
- Retry logic
- Auto-fix requests
- Final artifact verification

### 8. Project Engine
Multi-target output abstraction:
- Web projects
- App projects
- Game projects
- Future targets extensible

## Design Principles

1. **No Duplicate Architecture** — Core built once, extended only
2. **Provider-Agnostic** — No hard dependencies on specific providers
3. **Extensible** — New resources, agents, domains via interfaces
4. **Scalable** — Job queue supports linear scaling
5. **Isolated** — Docker sandbox for safe execution
6. **Licensed** — Open source resources tracked with license metadata
7. **Verifiable** — No unverified APIs claimed as implemented
8. **Preserving** — Existing Agnes integration wrapped as adapter

## Directory Structure

```
backend/
├── core/
│   ├── __init__.py
│   ├── orchestrator.py          # Central coordination
│   ├── intent_analyzer.py       # Intent classification
│   ├── planner.py              # Task decomposition
│   ├── quality_controller.py    # Validation & QC
│   └── project_engine.py        # Multi-target output
│
├── resources/
│   ├── __init__.py
│   ├── registry.py              # Resource registry
│   ├── base.py                 # Resource base class
│   ├── adapters/
│   │   ├── __init__.py
│   │   └── agnes_adapter.py    # Agnes AI adapter
│   └── metadata.py              # License & metadata tracking
│
├── agents/
│   ├── __init__.py
│   ├── base.py                 # Agent interface
│   ├── creative_agent.py
│   ├── coding_agent.py
│   ├── media_agent.py
│   ├── game_agent.py
│   └── product_agent.py
│
├── jobs/
│   ├── __init__.py
│   ├── models.py               # Job data structures
│   ├── queue.py                # Job queue
│   ├── worker.py               # Job worker
│   └── executor.py             # Execution engine
│
├── sandbox/
│   ├── __init__.py
│   ├── docker_manager.py        # Docker interface
│   ├── isolate.py              # Isolation logic
│   └── Dockerfile              # Sandbox container
│
├── api/
│   ├── __init__.py
│   ├── routes.py               # API endpoints
│   └── schemas.py              # Request/response models
│
├── config.py                    # Configuration
├── main.py                      # FastAPI entry
└── requirements.txt             # Dependencies
```

## Integration Points

### Agnes AI
Existing integration preserved as Resource Adapter:
- `/core/resources/adapters/agnes_adapter.py`
- Not hardcoded into Orchestrator
- Pluggable like any other resource
- Can be enabled/disabled

### Future Resources
Can be added without modifying core:
1. Implement `Resource` interface
2. Register in `ResourceRegistry`
3. Include license metadata
4. Orchestrator automatically discovers

## Testing Strategy

1. Unit tests for each component
2. Integration tests for workflows
3. End-to-end test: Simple prompt → Output
4. Docker sandbox isolation tests
5. Job queue concurrency tests

## Next Phases (After Core)

Once core architecture is complete:

1. **Domain Expansion** — Add new capabilities
   - Create Domain Capability module
   - Add Domain Agents
   - Add Domain Resources
   - Add Domain Workflows
   - Add Output Adapter
   - NO core changes needed

2. **Target Expansion** — Add new project types
   - Implement Target interface
   - Add to Project Engine
   - Configure build/run/test
   - NO core changes needed

3. **Resource Expansion** — Add new resources
   - Implement Resource interface
   - Register with metadata
   - Test integration
   - NO core changes needed
