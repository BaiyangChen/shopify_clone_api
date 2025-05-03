#添加分类
puts "🌱 Seeding categories..."

Category.destroy_all

cat1 = Category.create!(name: "Clothing")
cat2 = Category.create!(name: "Pet Products")

puts "✅ Categories created!"


#添加商品
puts "🌱 Seeding products..."

Product.destroy_all

Product.create!([
  {
    name: "good dog food",
    description: "pet food",
    price: 58.99,
    image_url: "https://s7d2.scene7.com/is/image/PetSmart/5309276?fmt=webp&wid=400&hei=400",
    category_id: 2
  },
  {
    name: "Nike jogger",
    description: "Nike Tech",
    price: 58.99,
    image_url: "https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/e9fe19a7-ed88-49fb-bdd5-166be2fe2e5a/M+NK+TCH+FLC+JGGR.png",
    category_id: 1
  },
  {
    name: "Nike Full Zip",
    description: "Orange Jacket",
    price: 120.0,
    image_url: "https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/569c1350-a17a-43c4-a0ca-a638a8e94018/M+NK+TCH+FLC+FZ+WR+HOODIE.png",
    category_id: 1
  },
  {
    name: "Woman nike top",
    description: "Woman nike full Zip",
    price: 78.99,
    image_url: "https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/d5d1d939-a85b-4047-aec3-7046585c02e8/PSG+WNSW+TCH+FLC+WR+FZ+HDY+ESN.png",
    category_id: 1
  },
  {
    name: "Nike Sportswear Tech Fleece",
    description: "Layer up with low-profile warmth in this duster jacket...",
    price: 168.0,
    image_url: "https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/c2e92f27-90fb-4d13-8260-9b4c5c70ce9b/W+NSW+TCH+FLC+OS+DUSTER.png",
    category_id: 1
  },
  {
    name: "Men's Fleece Hoodie",
    description: "We took our iconic smooth-on-both-sides fleece...",
    price: 122.98,
    image_url: "https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/08906f18-828b-47a0-a461-6d6b59c4c800/M+NK+TCH+FLC+HOODIE.png",
    category_id: 1
  },
  {
    name: "FFF Tech Fleece",
    description: "Stay comfy while you root for your squad...",
    price: 150.0,
    image_url: "https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/1a7176b7-3aff-447a-9bb4-1c9b1a77cb80/FFF+M+NSW+TCH+FLC+JGGR+PANT.png",
    category_id: 1
  },
  {
    name: "JW Hol-ee Roller Ball",
    description: "This product is available in a variety of sizes...",
    price: 5.59,
    image_url: "https://www.homesalive.ca/media/catalog/product/j/w/jw-pet-hol-ee-roller-red.jpg?quality=80&bg-color=255,255,255&fit=bounds&height=700&width=700&canvas=700:700",
    category_id: 2
  },
  {
    name: "JW Squeak-ee Playplace Ball",
    description: "The JW Squeak-ee Playplace Ball will make an excellent toy...",
    price: 4.79,
    image_url: "https://www.homesalive.ca/media/catalog/product/s/q/squeak-ee-ball-set.jpg?quality=80&bg-color=255,255,255&fit=bounds&height=700&width=700&canvas=700:700",
    category_id: 2
  },
  {
    name: "JW Crackle Heads Ball",
    description: "The JW Crackle Heads toys are sure to crack both you and your dog up...",
    price: 7.19,
    image_url: "https://www.homesalive.ca/media/catalog/product/j/w/jw-crackle-ball-green.jpg?quality=80&bg-color=255,255,255&fit=bounds&height=700&width=700&canvas=700:700",
    category_id: 2
  },
  {
    name: "Go! Solutions Joint Health Booster for Dogs",
    description: "The inclusion of a savoury gravy not only makes this topper...",
    price: 2.59,
    image_url: "https://www.homesalive.ca/media/catalog/product/1/6/16_33.jpg?quality=80&bg-color=255,255,255&fit=bounds&height=700&width=700&canvas=700:700",
    category_id: 2
  }
])

puts "✅ Done seeding!"


#添加admin 用户
puts "🌱 Seeding admin user..."

User.destroy_all

User.create!(
  email: "test@example.com",
  password: "123456", # 这里用明文写入，Rails 自动加密
  admin: true
)

puts "✅ Admin user created!"
