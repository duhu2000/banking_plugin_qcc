TASK:          Outreach Sequence -- David Chen / Lumen Health
ICP MATCH:     STRONG
CONFIGURATION: Not configured
VERIFY DATA:   All prospect data should be verified before outreach

OUTREACH SEQUENCE: David Chen / Lumen Health

---

Lead tier: WARM
Sequence: 5 touches over 35 days
Goal: 20-minute intro call
Channels: Email x3 + LinkedIn x2

HOOK DISTRIBUTION PLAN:
- Touch 1: Top 50 Healthtech list + David's move from Salesforce (5 months ago)
- Touch 2: SDR/Marketing Ops hiring signals + his engagement with VP Marketing post
- Touch 3: Problem insight on scaling RevOps data across growing teams (no ask)
- Touch 4: MedSync case study (4 data sources → 1 dashboard, 34% forecast accuracy)
- Touch 5: Graceful close

---

TOUCH 1 -- Day 1 | Email

Subject: Lumen Health on the Top 50 list -- and a RevOps question

David,

Congrats on Lumen making the Top 50 Healthtech to Watch list -- well deserved given the traction in EHR integration middleware.

Five months into building RevOps at a company on that kind of growth trajectory (especially coming from Salesforce, where you saw how RevOps scales at the enterprise level) -- I imagine you're already seeing where mid-market healthtech data infrastructure starts to strain.

I'd love to hear how you're thinking about data unification as Lumen scales. Would a 20-minute conversation be useful?

Word count: 83

---

TOUCH 2 -- Day 7 | LinkedIn

David, I noticed Lumen is hiring 3 SDRs and a Marketing Ops Manager -- that's a serious growth push. Scaling the team is the easy part; making sure the data layer keeps up is where most RevOps leaders hit friction.

I also saw you engaged with our VP Marketing's post on CRM data hygiene last month -- sounds like this is already on your radar. Happy to share what we're seeing in healthtech RevOps scaling if it's useful.

Word count: 73

---

TOUCH 3 -- Day 14 | Email

Subject: What happens to RevOps data when the team doubles

David,

No pitch here -- just a pattern I thought you'd want to know about given where Lumen is headed.

When healthtech companies in the $25-40M ARR range start scaling their go-to-market teams (which the SDR and Marketing Ops hires suggest Lumen is doing), RevOps data typically fragments across 3-5 disconnected sources: CRM, marketing automation, billing, product usage, and support. Each team adds their own tooling, and forecast accuracy drops because nobody's working from the same numbers.

The companies that avoid this usually solve it before the team doubles, not after. The three things they prioritize: a single source of truth for pipeline data, automated data hygiene across all sources, and forecast models that pull from unified data rather than manual spreadsheet reconciliation.

Happy to share more detail on any of these if it's relevant to what you're building.

Word count: 149

---

TOUCH 4 -- Day 28 | Email

Subject: How MedSync fixed the data fragmentation problem

David,

One concrete example that might be relevant given the growth phase Lumen is in.

MedSync -- healthtech company, similar ARR to Lumen -- was running RevOps across 4 separate data sources. Their forecast accuracy was suffering because every pipeline review started with 30 minutes of reconciling numbers from different systems. After consolidating everything into a single RevOps dashboard with DataBridge, they improved forecast accuracy by 34% within one quarter.

The part that resonated most with their RevOps lead: the team stopped debating whose numbers were right and started debating what to do about them.

Would 20 minutes to walk through how they approached it be worth your time?

Word count: 112

---

TOUCH 5 -- Day 35 | LinkedIn

David, I've reached out a few times about RevOps data unification as Lumen scales. I'll assume the timing isn't right or it's not the top priority right now. If that changes down the road, I'm here. Wishing you and the Lumen team well with the growth push.

Word count: 47

---

BRANCHING RULES:

- Reply received at any touch → EXIT SEQUENCE; alert rep immediately
- LinkedIn connection accepted without reply → warm follow-up DM (not the generic sequence touch)
- Email open (no click) after Touch 3 → move Touch 4 forward 3 days
- Bounce detected → pause sequence; alert rep; verify new email via /enrich

SEQUENCE COMPLETION:

- If no response after all touches: move to CULTIVATE nurture cadence
- Log in CRM: "Sequence completed -- [date] -- no response"
- Re-evaluate timing signal in 90 days via /enrich

---

FIVE LAWS COMPLIANCE CHECK:

| Law | Touch 1 | Touch 2 | Touch 3 | Touch 4 | Touch 5 |
|-----|---------|---------|---------|---------|---------|
| Law 1: Specific reference | Top 50 list + Salesforce background | SDR/MarOps hires + VP Marketing post engagement | Healthtech data fragmentation at $25-40M ARR | MedSync case study (same vertical) | Prior outreach referenced |
| Law 2: Lead with their problem | RevOps data strain at growth stage | Data layer keeping up with team growth | Data fragmentation across 3-5 sources | Forecast accuracy degradation | N/A (close) |
| Law 3: One ask | 20-minute conversation | Offer to share insights | No ask (value-add) | 20 minutes to walk through approach | No ask (close) |
| Law 4: Word count | 83 (Email ≤150) | 73 (LinkedIn ≤100) | 149 (Email ≤150) | 112 (Email ≤150) | 47 (LinkedIn ≤100) |
| Law 5: Human language | ✓ No jargon | ✓ No jargon | ✓ No jargon | ✓ No jargon | ✓ No jargon |

ALL OUTREACH OUTPUTS REQUIRE HUMAN REVIEW BEFORE SENDING.