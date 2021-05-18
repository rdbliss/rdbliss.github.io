---
layout: archive
title: "Teaching"
permalink: /teaching/
author_profile: false
---

{% include base_path %}

{% for class in site.teaching reversed %}
- [{{ class.title }}]({{ class.url }}), {{ class.semester }}
{% endfor %}
