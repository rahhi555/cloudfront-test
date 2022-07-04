import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/blogs',
      name: 'blogs',
      component: () => import('../views/Blogs.vue')
    },
    {
      path: '/blog/:id',
      name: 'blog-:id',
      component: () => import('../views/Blog.vue')
    },
    {
      path: '/create',
      name: 'blog-create',
      component: () => import('../views/CreateBlog.vue')
    },
  ]
})

export default router
