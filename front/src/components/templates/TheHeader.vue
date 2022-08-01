<script setup lang="ts">
import { RouterLink } from 'vue-router';
import { useAuth } from '@/stores/auth';
import { useSnackBar } from '@/composables/useSnackBar';
import { useRouter } from 'vue-router';

const router = useRouter();

const store = useAuth();
const logout = () => {
  store.logout();
  useSnackBar().show('ログアウトしました');
  router.push('/login');
};
</script>

<template>
  <header :class="$style.haeder">

    <nav v-if="store.isClient" :class="$style.nav">
      <RouterLink to="/">閲覧履歴</RouterLink>
      <RouterLink to="/blogs">ブックマーク</RouterLink>
      <RouterLink to="/blogs">予約履歴</RouterLink>
      <RouterLink to="/blogs">お礼投稿履歴</RouterLink>
      <RouterLink to="/account">登録情報</RouterLink>
    </nav>
    
    <nav v-else-if="store.isOffice" :class="$style.nav">
      <RouterLink to="/">事務所情報編集</RouterLink>
      <RouterLink to="/blogs">スタッフ情報</RouterLink>
      <RouterLink to="/blogs">お礼一覧</RouterLink>
      <RouterLink to="/blogs">予約状況確認</RouterLink>
      <RouterLink to="/account">利用者情報管理</RouterLink>
      <a @click="logout">ログアウト</a>
    </nav>

    <nav v-else :class="$style.nav">
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

