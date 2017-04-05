include:
  - kibana.install

{%- set plugins_pillar = salt['pillar.get']('kibana:plugins', {}) %}

{%- set plugin_bin = 'kibana-plugin' %}

{% for name, repo in plugins_pillar.items() %}
kibana-{{ name }}:
  cmd.run:
    - name: /usr/share/kibana/bin/{{ plugin_bin }} install {{ repo }}
    - require:
      - sls: kibana.install
    - unless: /usr/share/kibana/bin/{{ plugin_bin }} list | grep {{ name }}
{% endfor %}
