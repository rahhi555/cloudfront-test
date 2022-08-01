<script setup lang="ts">
import { RouterLink } from 'vue-router';

export type Props = {
  title: string;
  body: string;
  link: string;
  linkText: string;
}

defineProps<Props>()
</script>

<template>
  <div>
    <h1>{{ title }}</h1>
    <p>{{ body }}</p>
    <p>
      <RouterLink :to="link">{{ linkText }}</RouterLink>
    </p>
  </div>
</template>