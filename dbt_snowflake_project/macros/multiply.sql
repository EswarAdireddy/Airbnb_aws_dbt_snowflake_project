{% macro multiply(x,y,pre) %}
  round({{x}}*{{y}},{{pre}})
{% endmacro %}
