include:
  - kibana.install
  - kibana.service

{%- set plugins_pillar = salt['pillar.get']('kibana:plugins', {}) %}

{%- set plugin_bin = 'kibana-plugin' %}

{% for name, repo in plugins_pillar.items() %}
kibana-{{ name }}:
  cmd.run:
    - name: /usr/share/kibana/bin/{{ plugin_bin }} install {{ repo }}
    - runas: kibana
    - require:
      - sls: kibana.install
    - watch_in:
      - service: kibana-name
    - unless: /usr/share/kibana/bin/{{ plugin_bin }} list | grep {{ name }}
{% endfor %}
