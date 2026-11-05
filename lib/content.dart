typedef Experience = ({
  String title,
  String? subtitle,
  DateTime startDate,
  String? datePrefix,
  DateTime? endDate,
  String location,
  List<String> detail,
});

final C = (
  name: 'Kevin Kays',
  jobTitle: 'Principal Software Engineer and Consultant',
  email: 'okkays@pm.me',
  phone: '7576520310',
  web: 'okkays.com',
  headlineTags: [
    'Roommate of cat',
    'husband',
    'problem solver',
    'engineer',
    'consultant',
    'outdoor enthusiast',
  ],
  elevator: [
    r"I've spent my ten-plus years in software working with both tech industry giants and public-sector groups to lead, build, and mentor technical teams in pursuit of simple, practical solutions to loosely-defined problems.",
    r"",
    "For the past year, my wife and I (and our cat) took a Sabbatical to travel full time. We drove an RV we converted ourselves to the Arctic Ocean, ran/hiked over 2000km, XC skate and classic skied a few hundred more, descended a few dozen technical sandstone canyons, explored a few glaciers, enjoyed sunsets, and generally relished in the constant repairs, problem solving, and out-of-the-box thinking required from a life on the road.",
    r"",
    "We've finally reached the point where exploring new places, while still fun and exciting, doesn't feel like moving forward anymore, and we're ready to contribute to a community and build something lasting.",
    r"",
    r"That said, I'd love to spend my next ten-plus years working with a good group of people to build simple, efficient, maintainable tools and workflows that help others achieve their goals in a way that's economically, socially, and environmentally sustainable.",
  ],
  expertiseChips: [
    ["Vim"], // vim
    ["Python", "Flask", "Django", "Jinja"], // python
    ["Typescript", "Javascript", "Angular", "React"], // javascript
    ["Dart", "Flutter"], // dart
    ["Ruby", "Jekyll", "Rails", "ERB"], // ruby
    ["SQL", "postgres", "bigquery"], // sql
    ["HTML", "[s]css", "markdown"], // markup
    ["aws", "gcp", "cloud.gov", "terraform"], // cloud
    ["mac", "linux", "unix", "bash", "vimscript", "lua", "tmux"], // scripting
    ["webdriver", "playwright", "tdd"], // tests
    ["a11y", "lighthouse"], // a11y
    ["git", "github", "circleci"], // devops
    ["proposal writing", "documentation"], // docs
    ["interviewing", "cross functional"], // company
    ["debugging"], // general
    ["general it"],
  ],
  expertiseHeadline: [
    r"In additional to my technical skills, I put great effort into active listening, empowering teammates and clients, mentorship, solving miscommunication, continuously learning by recognizing my mistakes, and building patience through the understanding that progress takes work.",
    r"",
    r"I personally learn and grow by teaching and explaining what I know, plus new things I'm learning, to anyone who'll put up with me.",
  ],
  experience: <Experience>[
    (
      title: 'Nava PBC',
      subtitle: 'Principal Software Engineer and Technical Lead',
      startDate: DateTime(2022, 12),
      datePrefix: null,
      endDate: DateTime(2025, 12),
      location: 'Fully Remote',
      detail: [
        r"Technical Lead for Nava's projects with the Department of Justice (ada.gov and civilrights.justice.gov) and Massachusetts' Department of Early Education and Care",
        r"- Worked daily with internal and client-side Directors, technical leadership, compliance, front-line personnel, and cross-disciplinary groups to gather requirements, identify gaps, brainstorm solutions, and build technical proposals and solutions that passed bureaucratic scrutiny.",
        r"- Led cross-disciplinary teams of four to over a dozen internal, vendor, and client staff to break down work, distribute tasks, and iterate.",
        r"- As lead, was the last stop for solving or working around any technical problem that arose, including working with clients and end-users to adjust timelines, debug software, systems, networking, etc. ",
        r"- Participation in company bid work on top of (and without disruption to) normal project responsibilities, including proposal writing, teaming, and technical challenge work, contributing to awards such as the $100M HHS SWIFT BPA.",
        r"- Cross-project mentorship and participation in company-wide initiatives, hiring/interviewing, etc.",
      ],
    ),
    (
      title: 'Raybeam/DEPT @ Google',
      subtitle: 'Senior Software Engineer',
      startDate: DateTime(2015, 10),
      datePrefix: null,
      endDate: DateTime(2022, 12),
      location: 'Newburyport, MA',
      detail: [
        "When I joined, Raybeam was a 20-or-so person company tackling loosely-defined problems with a flat engineering-only project structure, we'd grown to 80+ people, learned, and evolved together. I played a key role in that evolution, especially with regards to our project work at Google, including:",
        "- Leading teams of four to fifteen people to design, produce, and deliver solutions used by hundreds of Google employees and vendors on a daily basis.",
        "- Achieving readability in Python, Typescript, Java, and AIP, making me the first person at Raybeam certified to submit and review Google code autonomously.",
        "- Mentoring, enabling, and advocating for teammates and engineers across our company to achieve the same level of ability and client trust.",
        "- Assembling, augmenting, and training teammates on a scalable framework for our projects, adhering to strict security and licensing constraints",
        "- Implementing a rigorous, adaptable devops workflow across all Raybeam@Google engineering teams emphasizing small, logical changes, with automated authoring, review, testing, deployment, and reporting",
        r"",
        "I also regularly volunteered for and led initiatives designed to make our company an easier, more enjoyable, more rewarding place to work.",
      ],
    ),
  ],
  education: <Experience>[
    (
      title: 'Virginia Tech',
      subtitle: 'Bachelor of Computer Science',
      startDate: DateTime(2011, 8),
      datePrefix: null,
      endDate: DateTime(2015, 5),
      location: 'Blacksburg, VA',
      detail: [],
    ),
    (
      title: 'NOLS Wilderness Medicine',
      subtitle: 'Wilderness First Responder',
      startDate: DateTime(2024, 10),
      datePrefix: '(certified through)',
      endDate: DateTime(2028, 10, 18),
      location: 'Flagstaff, AZ',
      detail: [
        '- Training in patient assessment and management of various medical problems',
        '- Certification in Adult, Child, and Infant CPR, AED, and Airway Management',
        '- Certification in Epinephrine Auto-injector use',
      ],
    ),
  ],
  attributions: [
    'colors: [gruvbox.org](https://gruvbox/)',
    'regular font: [lato](https://www.latofonts.com/)',
    'monospace font: [sourcefoundry:hack](https://sourcefoundry.org/hack/)',
    'written by hand in dart/flutter',
  ],
);
