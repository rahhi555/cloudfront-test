<script setup lang="ts">
import { useAuth } from "@/stores/auth"
import { useRouter } from "vue-router"
import { useSnackBar } from "@/composables/useSnackBar"

const router = useRouter()

const store = useAuth()
const { name, email, tel, address } = store.user!

const logout = async () => {
  await store.logout()
  useSnackBar().show("ログアウトしました")
  router.push("/login")
}
</script>

<template>
  <div>
    <span>お名前</span>
    <p>{{name}}</p>
    <span>メールアドレス</span>
    <p>{{email}}</p>
    <span>パスワード</span>
    <p>非表示</p>
    <span>電話番号</span>
    <p>{{tel}}</p>
    <span>住所</span>
    <p>{{address}}</p>

    <button @click="logout">ログアウト</button>
  </div>
</template>