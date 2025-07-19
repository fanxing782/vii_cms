import { ActionIcon, useMantineColorScheme } from '@mantine/core'
import { IconSun, IconMoon, IconDeviceDesktop } from '@tabler/icons-react'
import { useEffect } from 'react'

export function ToggleTheme() {
  const { colorScheme, setColorScheme } = useMantineColorScheme()

  // 处理系统主题变化
  useEffect(() => {
    if (colorScheme !== 'auto') return

    const mediaQuery = window.matchMedia('(prefers-color-scheme: dark)')

    const handleSystemThemeChange = (e: MediaQueryListEvent) => {
      const systemTheme = e.matches ? 'dark' : 'light'
      document.documentElement.classList.toggle('dark', systemTheme === 'dark')
    }

    // 初始设置
    const systemTheme = mediaQuery.matches ? 'dark' : 'light'
    document.documentElement.classList.toggle('dark', systemTheme === 'dark')

    // 监听系统主题变化
    mediaQuery.addEventListener('change', handleSystemThemeChange)
    return () => mediaQuery.removeEventListener('change', handleSystemThemeChange)
  }, [colorScheme])

  // 处理手动主题切换
  const toggleTheme = () => {
    const themes: Array<'light' | 'dark' | 'auto'> = ['light', 'dark', 'auto']
    const currentIndex = themes.indexOf(colorScheme)
    const nextScheme = themes[(currentIndex + 1) % themes.length]

    setColorScheme(nextScheme)

    // 手动设置时更新class
    if (nextScheme !== 'auto') {
      document.documentElement.classList.toggle('dark', nextScheme === 'dark')
    }
  }

  // 获取当前显示的图标和提示文本
  const getThemeState = () => {
    switch (colorScheme) {
      case 'light':
        return {
          icon: <IconSun size={18} className="text-yellow-400" />,
          label: '浅色模式',
        }
      case 'dark':
        return {
          icon: <IconMoon size={18} className="text-blue-400" />,
          label: '深色模式',
        }
      case 'auto':
        return {
          icon: <IconDeviceDesktop size={18} className="text-gray-500" />,
          label: '跟随系统',
        }
      default:
        return { icon: <IconDeviceDesktop size={18} />, label: '跟随系统' }
    }
  }

  const { icon, label } = getThemeState()

  return (
    <ActionIcon
      onClick={toggleTheme}
      variant="default"
      size="lg"
      aria-label={label}
      title={label}
      className="text-gray-700 dark:text-gray-300">
      {icon}
    </ActionIcon>
  )
}

// export function ToggleTheme() {
//   const { colorScheme, toggleColorScheme } = useMantineColorScheme()
//   return (
//     <ActionIcon
//       onClick={() => toggleColorScheme()}
//       variant='default'
//       size='lg'
//       aria-label='Toggle theme'
//       className='text-gray-700 dark:text-gray-300'>
//       {colorScheme === 'dark' ? (
//         <IconSun size={18} className='text-yellow-400' />
//       ) : (
//         <IconMoon size={18} className='text-blue-600' />
//       )}
//     </ActionIcon>
//   )
// }
