 1    import sys, pygame
 2    pygame.init()
 3
 4    size = width, height = 320, 240
 5    speed = [2, 2]
 6    black = 0, 0, 0
 7
 8    screen = pygame.display.set_mode(size)
 9
10    ball = pygame.image.load("ball.bmp")
11    ballrect = ball.get_rect()
12
13    while 1:
14        for event in pygame.event.get():
15            if event.type == pygame.QUIT: sys.exit()
16
17        ballrect = ballrect.move(speed)
18        if ballrect.left < 0 or ballrect.right > width:
19            speed[0] = -speed[0]
20        if ballrect.top < 0 or ballrect.bottom > height:
21            speed[1] = -speed[1]
22
23        screen.fill(black)
24        screen.blit(ball, ballrect)
25        pygame.display.flip()
