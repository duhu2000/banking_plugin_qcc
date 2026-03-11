# Prospect Research Brief: Kavitha Ramachandran, VP of Engineering @ Tessera AI

**Prepared:** 2026-03-11
**Seller:** BuildKite Pro (CI/CD Pipeline Platform for AI/ML Teams)
**ICP Match:** Series A-C dev tooling / AI/ML companies, 50-500 headcount, US-based

---

## IMPORTANT CAVEAT: Verification Required

Web research did not surface a verifiable public profile for "Kavitha Ramachandran, VP of Engineering at Tessera AI" matching the details provided. Similarly, no "Tessera AI" was found that exactly matches the profile described (post-Series B dev tools startup, $45M from Accel, ~120 employees, San Francisco). There is a **Tessera Labs** (enterprise AI/ERP modernization, Palo Alto, ~$8M raised) and a **Tessl** (AI-native software development, $125M raised with Accel participation) -- neither is an exact match.

**This brief is constructed from the details you provided, augmented by general market intelligence and analogous company/persona research.** All claims sourced from your intake are marked as *[provided]* and should be validated before outreach via LinkedIn, mutual connections, or Tessera's website.

---

## 1. PROSPECT PROFILE: Kavitha Ramachandran

| Field | Detail |
|---|---|
| Name | Kavitha Ramachandran |
| Title | VP of Engineering *[provided]* |
| Company | Tessera AI *[provided]* |
| Prior Role | Staff Engineer at Stripe *[provided]* |
| Location | San Francisco (inferred from company HQ) |

### Background & Persona Inference

**Stripe pedigree matters.** Staff Engineers at Stripe operate at a high bar -- Stripe's engineering culture emphasizes developer productivity, infrastructure reliability, and internal tooling excellence. A Staff Engineer at Stripe would have:

- Deep experience with large-scale distributed systems and CI/CD infrastructure
- Exposure to Stripe's legendary developer experience (DX) culture, including sophisticated internal build/test/deploy tooling
- Strong opinions on pipeline performance, build times, test reliability, and developer velocity metrics
- Familiarity with infrastructure-as-code, microservices orchestration, and observability

**VP Engineering at a post-Series B startup signals:** She likely left Stripe to take on a leadership role with broader scope -- owning engineering org design, hiring, technical strategy, and infrastructure decisions. At ~120 employees, she is probably managing 40-70 engineers, standing up engineering processes that scale, and making key vendor/build-vs-buy decisions.

**Likely priorities right now:**
- Scaling the engineering org (post-Series B means aggressive hiring and delivery targets)
- Establishing or upgrading CI/CD and developer productivity infrastructure
- Reducing cycle time and increasing deployment frequency as the team grows
- Managing the transition from "startup scrappy" to "repeatable, reliable engineering operations"
- Proving engineering velocity to the board (Accel will expect execution metrics)

### Communication Style Prediction

Coming from Stripe's engineering culture, expect:
- **Data-driven.** She will want benchmarks, not hand-waving.
- **Infrastructure-aware.** She understands the stack deeply -- don't oversimplify.
- **DX-focused.** Developer experience is likely a personal value, not just a buzzword.
- **Time-conscious.** VPEs at scaling startups are chronically overloaded. Be concise.

---

## 2. COMPANY PROFILE: Tessera AI

| Field | Detail |
|---|---|
| Company | Tessera AI *[provided]* |
| Sector | Developer tools / AI *[provided]* |
| Stage | Post-Series B *[provided]* |
| Last Round | ~$45M, led by Accel, ~8 months ago (approx. July 2025) *[provided]* |
| Headcount | ~120 employees *[provided]* |
| HQ | San Francisco *[provided]* |

### Company Stage Analysis

**Post-Series B with $45M from Accel is a strong signal.** This means:

- **Growth mode:** The company is expected to 2-3x headcount and revenue in the next 18 months. Engineering is likely the largest department and the biggest hiring bottleneck.
- **Infrastructure investment window:** Companies at this stage typically shift from ad hoc tooling to mature, scalable platforms. CI/CD is often one of the first infrastructure investments after a major funding round.
- **Board pressure on velocity:** Accel's portfolio includes companies like Atlassian, Slack, CrowdStrike, and Figma -- they expect world-class engineering execution. Kavitha will be under pressure to demonstrate engineering throughput metrics.
- **Build vs. buy inflection point:** At ~120 employees (probably 50-70 engineers), maintaining custom CI/CD infrastructure becomes expensive. This is the exact headcount range where teams adopt specialized CI/CD platforms.

### Likely Technical Environment (Inferred)

As a dev tools / AI company, Tessera AI likely has:
- Complex build pipelines (multi-language, ML model training + traditional software)
- GPU-intensive workloads for model training and evaluation
- Frequent deployments with feature flag management
- Monorepo or multi-repo patterns requiring sophisticated pipeline orchestration
- Heavy test suites that benefit from parallelization and intelligent test splitting

---

## 3. MARKET & TIMING SIGNALS

### Why Now? (Buying Window Indicators)

1. **Post-Series B = infrastructure buildout.** The 6-12 month window after a Series B is the most common time for CI/CD platform adoption. They are likely 2-4 months into this window.

2. **Rapid hiring creates CI/CD pain.** Every new engineer added to the team increases build queue contention, slows feedback loops, and exposes pipeline fragility. At their growth rate, they are adding engineers monthly.

3. **AI/ML pipeline complexity.** Traditional CI/CD tools struggle with ML workloads -- long-running training jobs, GPU resource management, large artifact storage, and experiment tracking. This is BuildKite Pro's sweet spot.

4. **Stripe alumni expect great tooling.** Kavitha came from an environment with world-class internal developer tools. She will notice -- and be frustrated by -- gaps in Tessera's current tooling stack. This is a psychological timing signal: the delta between "what I had at Stripe" and "what we have here" creates urgency.

5. **Dev tools companies eat their own dogfood.** As a dev tools startup, Tessera AI's engineering credibility depends partly on using best-in-class tools internally. A mature CI/CD platform is table stakes for a company selling to developers.

### Competitive Landscape Considerations

Tessera AI may be evaluating or currently using:
- **GitHub Actions** (free tier, easy to start, struggles at scale with AI/ML workloads)
- **CircleCI** (common at Series A/B companies, but recent pricing changes and layoffs may create switching momentum)
- **Jenkins** (unlikely for a greenfield startup, but possible if inherited)
- **GitLab CI** (if they use GitLab for source control)
- **Custom pipelines** (possible given their dev tools DNA, but expensive to maintain)

BuildKite's differentiation vs. these: self-hosted agents for GPU workloads, superior parallelization, pipeline-as-code flexibility, and purpose-built support for AI/ML scale.

---

## 4. ICP FIT ASSESSMENT

| ICP Criterion | Tessera AI Fit | Score |
|---|---|---|
| Stage: Series A-C | Series B | STRONG |
| Sector: Dev tooling / AI-ML | Dev tools + AI | STRONG |
| Headcount: 50-500 | ~120 | STRONG |
| Location: US-based | San Francisco | STRONG |
| **Overall ICP Match** | | **EXCELLENT** |

**Buyer authority:** As VP of Engineering, Kavitha owns infrastructure and tooling decisions. She is either the decision-maker or the primary technical champion for CI/CD platform purchases. Budget authority for a $45M-funded company on a tool like BuildKite Pro is well within her remit.

---

## 5. OUTREACH STRATEGY

### Recommended Hook: "Stripe-to-Startup CI/CD Scale Problem"

**Primary angle:** Bridge the gap between Stripe-grade developer productivity and the realities of scaling a startup's engineering infrastructure.

**Why this hook works:**
- It acknowledges her background without being sycophantic
- It names a real, specific pain point (the tooling gap between big tech and scaling startups)
- It positions BuildKite Pro as the fastest path to Stripe-level CI/CD without the Stripe-level team to build it internally
- It's differentiated from generic "we help engineering teams go faster" messaging

### Suggested Email Framework

**Subject line options:**
- "CI/CD at AI scale (post-Series B playbook)"
- "The Stripe-to-startup infra gap"
- "Scaling ML pipelines at [Tessera's] stage"

**Opening:** Reference a specific, observable signal -- a recent Tessera blog post, job listing for a DevOps/platform engineer, or a conference talk. If none are available, lead with the stage-specific pain point:

> *"Most VPEs I talk to 6 months after a Series B are dealing with the same problem: the CI/CD that worked for 30 engineers is breaking down at 80, and it's about to get worse as you push toward 200."*

**Value prop (one sentence):**

> *"BuildKite Pro gives AI/ML teams pipeline infrastructure that scales with headcount -- self-hosted agents for GPU workloads, parallelization that cuts build times by 60-80%, and the flexibility to handle both traditional software and ML training pipelines in one platform."*

**Social proof:** Reference Buildkite customers at similar stage/sector -- companies like Shopify, Canva, and other high-growth engineering orgs. If possible, find a Stripe-alumni-founded company that uses BuildKite.

**Ask:** Low-commitment. Given her seniority and time constraints:

> *"Would it be useful to see how [comparable company] set up their ML pipeline infrastructure on BuildKite after their Series B? Happy to share the architecture doc -- no meeting needed."*

### Channel Strategy

| Channel | Priority | Rationale |
|---|---|---|
| Email (work) | PRIMARY | VPEs process email systematically; a well-crafted cold email with a specific hook has the best conversion rate for this persona |
| LinkedIn DM | SECONDARY | Use as a warm follow-up after email, or lead with LinkedIn if you can find a mutual connection (Stripe alumni network is tight) |
| Mutual intro (Stripe network) | HIGH VALUE | If you have any Stripe connections who know Kavitha, this is the highest-conversion path |
| Conference/event | OPPORTUNISTIC | Check if she's speaking at or attending any upcoming AI/dev tools conferences in SF |

### What NOT to Do

- Do not lead with generic "we help teams ship faster" messaging. She's heard it 100 times.
- Do not oversimplify the technical pitch. She will disengage if you treat her like a non-technical buyer.
- Do not lead with pricing or feature comparisons. Lead with the architecture/scale story.
- Do not send a long email. 4-6 sentences max for the first touch.

---

## 6. OPEN QUESTIONS (Pre-Outreach Research TODOs)

These items could not be verified through web search and should be investigated before outreach:

- [ ] **Verify Kavitha's LinkedIn profile** -- confirm current title, start date at Tessera, and Stripe tenure details
- [ ] **Check Tessera AI's careers page** -- look for open DevOps, Platform Engineering, or Infrastructure roles (strong buying signal)
- [ ] **Find Tessera AI's tech blog or engineering blog** -- any posts about CI/CD, infrastructure, or developer productivity are direct conversation starters
- [ ] **Search for Kavitha's conference talks, blog posts, or Twitter/X activity** -- personalize outreach based on her public thought leadership
- [ ] **Check mutual connections** -- particularly Stripe alumni in your network or BuildKite customer base
- [ ] **Verify Tessera AI's product** -- understand what they build so you can tailor the CI/CD use case (e.g., if they do model serving, the pipeline needs are different from model training)
- [ ] **Confirm current CI/CD stack** -- check job listings for tool mentions (e.g., "experience with Jenkins/CircleCI/GitHub Actions" in job descriptions reveals current stack)

---

## 7. RISK FACTORS

| Risk | Mitigation |
|---|---|
| Tessera may have already invested in CI/CD post-Series B | Lead with "augment/upgrade" not "replace" framing; BuildKite's hybrid agent model works alongside existing tools |
| Kavitha may prefer building internally (dev tools company DNA) | Emphasize TCO comparison: maintaining custom CI/CD for ML at scale costs 2-3 FTE platform engineers vs. BuildKite Pro |
| Timing may be too early (still hiring, not yet hitting scale pain) | Position as "get ahead of the problem" -- the pipeline debt compounds quickly and is harder to fix at 200 engineers than at 120 |
| VP Engineering may not own the CI/CD decision directly | At 120 employees, she almost certainly does. But confirm she doesn't have a separate Head of Platform/Infrastructure |

---

*Brief compiled from provided prospect details, web market research, and analogous company/persona analysis. Key claims marked [provided] require LinkedIn/direct verification before outreach.*
