<script setup lang="ts">
import { RouterLink } from 'vue-router';
</script>

<template>
  <header :class="$style.haeder">
    <nav :class="$style.nav">
      <RouterLink to="/">閲覧履歴</RouterLink>
      <RouterLink to="/blogs">ブックマーク</RouterLink>
      <RouterLink to="/blogs">予約履歴</RouterLink>
      <RouterLink to="/login">ログイン</RouterLink>
      <RouterLink to="/signup">新規登録</RouterLink>
    </nav>
  </header>
</template>

<style module>
.haeder {
  margin-bottom: 3rem;
}
.nav a:not(:first-child) {
  margin-left: 1rem;
}
</style>

