<script setup lang="ts">
import { RouterLink } from 'vue-router';
</script>

<template>
  <div style="margin: auto; width: 1000px">
    <h1>ブログ一覧画面</h1>
    <div>
      <RouterLink to="/">TOP</RouterLink>
    </div>
    <div>
      <RouterLink to="/create">記事作成画面</RouterLink>
    </div>
  </div>
</template>
