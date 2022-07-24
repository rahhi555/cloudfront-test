<script setup lang="ts">
import { ref, reactive } from 'vue'
import { RouterLink } from 'vue-router';
import { BlogsApi } from '@/../types/fetch/apis'
import type { Blog } from '@/../types/fetch/models'
import { DefaultConfig, Configuration } from '../../types/fetch/runtime'

DefaultConfig.config = new Configuration({
  basePath: import.meta.env.PROD ? "https://api.home-care-navi-second.work:3000" : "http://localhost:3000",
})

const blogs = ref<Blog[]>()
new BlogsApi().getBlogs().then(res => blogs.value = res)

const blogParams = reactive({
  title: '',
  contents: '',
})

const createBlog = async () => {
  const data = await new BlogsApi().createBlog({
    createBlogRequest: {
      title: blogParams.title,
      contents: blogParams.contents,
    },
  })
  
  blogs.value?.push(data)
}
</script>

<template>
  <div style="margin: auto; width: 1000px">
    <h2>テスト投稿</h2>
    <div>
      <RouterLink to="/">TOP</RouterLink>
    </div>
    <ul>
      <li v-for="blog in blogs">{{blog.title}}</li>
    </ul>

    <input type="test" v-model="blogParams.title" />
    <button @click="createBlog">テスト投稿</button>
  </div>
</template>
