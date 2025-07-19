'use client'

import { useMantineColorScheme } from '@mantine/core'
import { useEffect } from 'react'

export function ThemeManager() {
  const { colorScheme } = useMantineColorScheme()

  useEffect(() => {
    const html = document.documentElement
    const mediaQuery = window.matchMedia('(prefers-color-scheme: dark)')

    // 处理系统主题变化
    const handleSystemThemeChange = (e: MediaQueryListEvent) => {
      if (colorScheme === 'auto') {
        const systemTheme = e.matches ? 'dark' : 'light'
        html.classList.toggle('dark', systemTheme === 'dark')
      }
    }

    // 设置初始主题
    const applyTheme = () => {
      if (colorScheme === 'auto') {
        const systemTheme = mediaQuery.matches ? 'dark' : 'light'
        html.classList.toggle('dark', systemTheme === 'dark')
      } else {
        html.classList.toggle('dark', colorScheme === 'dark')
      }
    }

    applyTheme()

    // 监听系统主题变化（仅在auto模式时生效）
    mediaQuery.addEventListener('change', handleSystemThemeChange)

    return () => {
      mediaQuery.removeEventListener('change', handleSystemThemeChange)
    }
  }, [colorScheme])

  return null
}
