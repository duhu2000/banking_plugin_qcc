# Buyer Persona: VP of Engineering -- Mid-Market B2B SaaS (200-1000 Employees)

## WHO THEY ARE

**Title:** Vice President of Engineering (sometimes SVP Engineering or Head of Engineering at smaller orgs)

**Career trajectory:** Typically 12-18 years in software engineering. Rose through Senior Engineer -> Engineering Manager -> Director of Engineering -> VP. Most have managed 30-150 engineers across multiple teams. Many came up through IC tracks at companies like Atlassian, Shopify, HubSpot, or similar mid-market SaaS companies before stepping into leadership. Some made the leap from big tech (FAANG) to mid-market for broader scope and ownership.

**Scope of authority:** Owns engineering headcount (typically 50-200 engineers), tooling budget, and engineering process decisions. Reports to CTO or CEO. Responsible for shipping cadence, engineering quality, team retention, and increasingly, developer experience as a strategic function. Controls or heavily influences tooling spend in the $50K-$500K range without board approval.

**Demographics:** Predominantly 35-48 years old. Still technically literate -- they read code, understand architecture decisions, and can smell vendor BS from a mile away. They stopped writing production code 3-5 years ago but stay close to the technical details.

**What defines them:** They live at the intersection of technical execution and business outcomes. Their CTO and CEO want faster shipping velocity. Their engineering managers want less toil and fewer context switches. Their ICs want fewer tools, not more. The VP of Engineering is the person trying to reconcile all three while keeping attrition below 15%.

---

## WHAT THEY WANT (Motivations & Success Metrics)

They are evaluated on and obsess over:

- **Engineering velocity:** Not lines of code -- cycle time, deployment frequency, lead time for changes. They track DORA metrics or something similar, even if informally.
- **Talent retention:** Losing a senior engineer costs $250K+ in recruiting, ramp, and lost institutional knowledge. They know this number. Anything that makes engineers' lives better is a retention play.
- **Shipping cadence:** Can the team predictably deliver on quarterly commitments? The VP is accountable to the CEO for roadmap delivery.
- **Engineering capacity planning:** They need to answer "do we need to hire 10 more people or can we get more out of the team we have?" This is a board-level question and they need data to answer it.
- **Reduction of engineering toil:** Time spent on CI/CD pipeline failures, flaky tests, environment provisioning, and other non-feature work is their enemy. They want that ratio to shift.

**What "winning" looks like to them:** Shipping faster with the same or fewer people, retaining top talent, and being able to show the CEO a dashboard that proves engineering is not the bottleneck.

---

## WHAT THEY FEAR (Pain Points & Risks)

- **Tool fatigue and team resistance:** This is the number one objection you hear ("my team will resist another tool in the stack") because they have lived through failed rollouts. They have seen engineering teams revolt against mandated tools that added friction instead of removing it. They fear being the person who forced a tool on the team that nobody uses.
- **Failed rollout making them look bad:** If they champion a $100K+ purchase and adoption stalls at 20%, their credibility with the CTO and CEO takes a hit. The political risk is real.
- **Vendor hype vs. reality:** They have been burned by vendors promising "10x productivity" and delivering marginal improvement. Every inflated claim triggers skepticism because they have the technical depth to know when something is exaggerated.
- **Integration complexity:** Their stack is already complex. Adding a tool that requires significant integration work or doesn't play well with existing CI/CD (GitHub Actions, CircleCI, Jenkins, etc.) is a non-starter.
- **Losing engineering time to evaluation:** Every POC costs engineering hours. They are protective of their team's time and will not greenlight an evaluation unless they are reasonably confident it will pay off.

---

## HOW THEY BUY

### Discovery
- They do not respond to cold outreach that leads with product features. They discover tools through engineering blogs (their own team's research), peer recommendations from other VPs at similar-stage companies, and conference hallway conversations.
- The initial interest is usually sparked by a specific pain point -- a quarter where deployment frequency dropped, a retention crisis, or a CEO asking "why does everything take so long?"
- The senior engineering manager (your champion) typically surfaces the tool first and brings it to the VP with a recommendation.

### Evaluation
- **POC is mandatory.** Expect a 2-4 week proof of concept with a single team before any commercial discussion. They will not buy based on demos alone. The POC must run on their actual codebase with their actual pipelines.
- They will assign 1-2 senior engineers to evaluate. Those engineers' feedback is effectively a veto. If the engineers say "this doesn't work with our setup" or "this adds friction," the deal is dead.
- They will benchmark against doing nothing. The bar is not "is this tool good?" -- it is "is this tool better than what my team could build internally or the status quo?"

### Decision
- The VP of Engineering is the economic buyer who signs. Budget authority is typically $100K-$300K without CEO approval; above that, CEO or CFO co-signs.
- Decision timeline: 4-8 weeks from POC completion to signature, assuming POC results are strong. Add 2-4 weeks if legal/procurement is involved.
- They will want to see: POC results with quantified impact (cycle time reduction, CI time savings), a rollout plan that minimizes disruption, and clear evidence of adoption at comparable companies.

### Blockers
- **"My team will resist another tool in the stack."** This is the primary objection. Reframe: "This replaces manual work your team already hates, not adds to it. Here is how [similar company] rolled out to 3 teams in 2 weeks with 85% voluntary adoption because engineers saw immediate value in their daily workflow. The adoption model is bottom-up -- engineers choose to use it because it removes friction, not because it is mandated."
- **Procurement/legal delays:** Mid-market companies often have immature procurement processes. Expect 2-4 weeks of back-and-forth on MSA terms. Offer a streamlined contract or a standard order form to accelerate.
- **Internal build vs. buy:** Some VPs will have a senior engineer who says "I can build this in a sprint." Counter with total cost of ownership: building is sprint one, but maintaining is forever. Show the ongoing maintenance burden of internal tooling.

---

## HOW TO COMMUNICATE

### Tone and register
- **Peer-level technical conversation.** They want to talk to someone who understands engineering systems, not a salesperson reading a script. If your AE cannot discuss CI/CD pipelines, DORA metrics, or developer experience with credibility, bring an SE from the first call.
- **Direct and evidence-based.** No preamble, no marketing fluff, no superlatives. They respect concise communication that respects their time.

### Language that resonates
- "Here is what we measured at [comparable company] over 90 days..."
- "Your engineers would evaluate this, and here is what they typically find..."
- "This replaces [specific manual process] -- not adds to your stack"
- "We see cycle time improvements of 15-25% in the first quarter based on [X] deployments"
- "The biggest risk is adoption -- here is our playbook for that"

### Language that kills credibility instantly
- **"10x productivity"** -- this is the single fastest way to lose this buyer. They know productivity is not 10x-able with a tool. Do not say it. Do not imply it.
- "Revolutionary" / "game-changing" / "paradigm shift" -- any marketing superlative triggers immediate skepticism
- "Our AI-powered platform..." as a leading statement -- they do not care about your technology; they care about their outcomes
- Leading with your company name or product name before establishing their problem
- Feature dumps without tying to their specific pain

### What to lead with
Lead with a specific, quantified outcome at a comparable company. Example: "We worked with a 300-person SaaS company where deployment frequency was stuck at twice a week. After 90 days, they were shipping daily with 40% fewer CI failures. The engineering team requested expansion to the other 4 teams. Happy to share how that played out if it is relevant to what you are seeing."

---

## WHERE TO REACH THEM

### Primary channels
- **Engineering leadership communities:** LeadDev Slack, Rands Leadership Slack, CTO Craft community. They participate in these communities for peer advice, not vendor pitches. Contribute value before ever mentioning your product.
- **LinkedIn:** They are active on LinkedIn but primarily consume, not post. Engage with their posts or shared articles. Do not send a cold InMail with a pitch. Send a thoughtful comment on something they shared, then a connection request.
- **Warm introductions:** The highest-converting channel. Ask your existing champion (the senior engineering manager) or a mutual connection for an introduction. VP of Engineering trusts peer recommendations above all other signals.

### Content they consume
- **Engineering blogs:** The Pragmatic Engineer (Gergely Orosz), StaffEng, Will Larson's blog (An Elegant Puzzle). If you can get featured or referenced in these publications, you have instant credibility.
- **Podcasts:** The Engineering Leadership Podcast, Software Engineering Daily, Lenny's Podcast (for product-adjacent topics)
- **Conferences:** QCon, LeadDev (London, New York, Berlin), StaffPlus, KubeCon (if infrastructure-adjacent), SREcon. They attend these for technical depth and peer networking. Sponsor strategically -- booths are ignored, but workshops and technical talks get attention.
- **Industry reports:** DORA State of DevOps Report, Thoughtworks Technology Radar. If your product aligns with findings in these reports, reference them.

### Timing of receptivity
- **Budget planning cycles:** Q4 (October-November) for the following year. If you are not in their budget plan by November, you are fighting for discretionary spend.
- **Post-attrition spikes:** When they lose 2-3 senior engineers in a quarter, they become acutely focused on developer experience and retention tools.
- **After a missed delivery milestone:** When the CEO asks "why did we miss the Q2 roadmap," the VP of Engineering starts looking for leverage to improve velocity.
- **New VP hire:** A VP of Engineering in their first 90 days is actively evaluating the tooling stack and looking for quick wins to demonstrate impact. This is a prime window.

---

## ACTIONABLE OUTREACH GUIDANCE

### First-touch sequence strategy

**Channel:** Warm introduction via the senior engineering manager champion, or LinkedIn engagement followed by a direct message.

**Message framework (not a template -- adapt to specifics):**

1. **Touch 1 (LinkedIn or email):** Reference a specific, verifiable fact about their company or engineering team (a blog post they published, a talk they gave, a job posting indicating growth). Connect it to an outcome you have delivered at a similar company. Ask a single question -- do not pitch. Example: "Saw your team's post on migrating to trunk-based development. We helped [Company X]'s team cut their CI cycle time by 35% during a similar transition. Curious if pipeline speed is a bottleneck you are thinking about this quarter?"

2. **Touch 2 (3-4 days later, same channel):** Share a relevant case study or data point. No ask. Just value. "Thought this might be useful -- [Company Y]'s engineering team published their results after optimizing their deployment pipeline. Similar team size to yours."

3. **Touch 3 (5-7 days later, email):** Direct ask for a 20-minute conversation. Frame it around their problem, not your product. "Would it be useful to compare notes on how other 300-person engineering orgs are approaching developer experience measurement? Happy to share what we are seeing across our customer base -- no pitch, just patterns."

**What not to do:** Do not send a 4-paragraph email about your platform. Do not request a 60-minute demo. Do not use the phrase "I'd love to pick your brain." Do not lead with your company name.

### Rep preparation checklist before first outreach
- [ ] Identify 1-2 engineering blog posts, talks, or job postings from the target company
- [ ] Find the senior engineering manager who is most likely the internal champion
- [ ] Prepare one comparable customer story (similar company size, similar tech stack, quantified outcome)
- [ ] Review the company's tech stack on StackShare, job postings, or GitHub repos
- [ ] Confirm the VP of Engineering's tenure -- new hires (< 6 months) are higher-priority targets

ALL OUTREACH OUTPUTS REQUIRE HUMAN REVIEW BEFORE SENDING.
