import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import { useAuth } from "@/stores/auth"

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/completed',
      name: 'completed',
      component: () => import('../views/Completed.vue'),
      props: true
    },
    {
      path: '/blogs',
      name: 'blogs',
      component: () => import('../views/Blogs.vue')
    },
    {
      path: '/login',
      name: 'login',
      component: () => import('../views/auth/Login.vue')
    },
    {
      path: '/signup',
      name: 'signup',
      component: () => import('../views/auth/SignUp.vue')
    },
    {
      path: '/signup_office',
      name: 'signup_office',
      component: () => import('../views/auth/SignUpOffice.vue')
    },
    {
      path: '/account',
      name: 'account',
      component: () => import('../views/auth/AccountInfo.vue')
    },
  ]
})

router.beforeEach(async () => {
  const { validateToken } = useAuth()
  await validateToken()
})

export default router
