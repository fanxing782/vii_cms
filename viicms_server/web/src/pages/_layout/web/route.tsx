import clsx from 'clsx'
import { useState } from 'react'
import { AppShell, NavLink, Burger, Group, Text } from '@mantine/core'
import { useDisclosure } from '@mantine/hooks'
import { IconHome2, IconUser, IconSettings } from '@tabler/icons-react'
import { createFileRoute, Outlet, useNavigate } from '@tanstack/react-router'
import { LoadingPlaceholder, ToggleTheme } from '~/components'
import classes from './route.module.css'

export const Route = createFileRoute('/_layout/web')({
  component: LayoutPage,
  pendingComponent: () => <LoadingPlaceholder />,
})

/**
 * 布局页面
 */
function LayoutPage() {
  const [mobileOpened, { toggle: toggleMobile }] = useDisclosure()
  const [desktopOpened, { toggle: toggleDesktop }] = useDisclosure(true)
  const [active, setActive] = useState(0)
  const navigate = useNavigate()

  // 菜单
  const navItems = [
    { label: 'Dashboard', icon: <IconHome2 size="1rem" />, path: '/web' },
    { label: 'Menu1', icon: <IconUser size="1rem" />, path: '/web/route1' },
    {
      label: 'Menu2',
      icon: <IconSettings size="1rem" />,
      path: '/web/route2',
    },
    {
      label: 'NotFound',
      icon: <IconSettings size="1rem" />,
      path: '/web/notfound',
    },
  ]

  return (
    <AppShell
      layout="alt"
      header={{ height: 60 }}
      navbar={{
        width: 300,
        breakpoint: 'sm',
        collapsed: { mobile: !mobileOpened, desktop: !desktopOpened },
      }}
      padding="md"
      classNames={{
        root: classes.root,
        main: classes.main,
        header: classes.header,
        navbar: classes.navbar,
      }}>
      {/* 头部导航栏 */}
      <AppShell.Header>
        <Group h="100%" px="md">
          <Burger opened={mobileOpened} onClick={toggleMobile} hiddenFrom="sm" size="sm" />
          <Burger opened={desktopOpened} onClick={toggleDesktop} visibleFrom="sm" size="sm" />
          <Text fw={700} size="xl">
            Admin Dashboard
          </Text>
          <ToggleTheme />
        </Group>
      </AppShell.Header>
      {/* 左侧菜单栏 */}
      <AppShell.Navbar p="md">
        <AppShell.Section grow className={classes.navbarSection}>
          <Burger opened={mobileOpened} onClick={toggleMobile} hiddenFrom="sm" size="sm" />
          {navItems.map((item, index) => (
            <NavLink
              key={item.path}
              label={item.label}
              leftSection={item.icon}
              className={clsx(classes.navLink, index === active && classes.navLinkActive)}
              active={index === active}
              onClick={() => {
                setActive(index)
                navigate({ to: item.path })
              }}
            />
          ))}
        </AppShell.Section>
        {/* 菜单栏底部 */}
        <AppShell.Section className={classes.footer}>
          <hr />
          <Text c="dimmed" size="sm">
            v1.0.0
          </Text>
        </AppShell.Section>
      </AppShell.Navbar>
      {/* 主要内容区域 */}
      <AppShell.Main>
        <div className={classes.content} color="body3">
          <Outlet />
        </div>
      </AppShell.Main>
    </AppShell>
  )
}
