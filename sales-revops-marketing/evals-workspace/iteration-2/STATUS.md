# Iteration 2 Actual Status

This report reflects the actual files present on disk. Missing runs were not backfilled or inferred.

## Coverage

- Defined eval cases: 45
- Completed eval cases (both outputs + both gradings present): 21
- Pending eval cases: 24
- Completed runs: 42
- Pending runs: 48
- Timing files present: 0

## Benchmark On Completed Subset

- With skill: 103/128 = 80.5%
- Without skill: 67/128 = 52.3%
- Delta: +28.1 points

## Highest Positive Deltas

- sales-marketing-global-router-eval-1: with 100%, without 17%, delta +83.0 pts
- copywriting-eval-1: with 100%, without 33%, delta +67.0 pts
- lead-scoring-eval-1: with 100%, without 33%, delta +67.0 pts
- outreach-eval-1: with 100%, without 33%, delta +67.0 pts
- prospect-research-eval-1: with 100%, without 33%, delta +67.0 pts
- pipeline-eval-1: with 71%, without 29%, delta +42.0 pts
- content-creation-eval-1: with 67%, without 33%, delta +34.0 pts
- prospect-research-eval-2: with 67%, without 33%, delta +34.0 pts

## Zero-Delta Cases

- campaign-planning-eval-2: both 100%
- content-calendar-eval-1: both 17%
- copywriting-eval-2: both 100%
- copywriting-eval-3: both 100%
- crm-enrichment-eval-1: both 100%
- lead-scoring-eval-2: both 100%
- performance-analysis-eval-1: both 50%
- persona-icp-eval-2: both 100%

## Pending Cases

- campaign-planning-eval-3
- content-calendar-eval-2
- content-calendar-eval-3
- content-creation-eval-2
- content-creation-eval-3
- crm-enrichment-eval-2
- crm-enrichment-eval-3
- follow-up-eval-2
- follow-up-eval-3
- lead-scoring-eval-3
- outreach-eval-2
- outreach-eval-3
- performance-analysis-eval-2
- performance-analysis-eval-3
- persona-icp-eval-3
- pipeline-eval-2
- pipeline-eval-3
- pre-call-brief-eval-2
- pre-call-brief-eval-3
- prospect-research-eval-3
- sales-marketing-global-router-eval-2
- sales-marketing-global-router-eval-3
- sequence-eval-2
- sequence-eval-3

## Blocking Issue

- The remaining 24 eval cases were not executed because the local Claude CLI hit its rate limit during the prior session and remains blocked until reset.
