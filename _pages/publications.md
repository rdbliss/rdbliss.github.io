---
layout: archive
title: "Publications"
permalink: /publications/
author_profile: false
---

{% include base_path %}

Below is a list of my publications. You can find a more functional list on
[Google Scholar](https://scholar.google.com/citations?user=9FN7rdsAAAAJ&hl=en),
but here I can add little notes and thoughts to everything.

{% assign sorted = site.publications | sort: 'date' | reverse %}

{% for pub in sorted %}
- [{{ pub.title }}]({{ pub.url }}) By {{ pub.authors }}
{% endfor %}
