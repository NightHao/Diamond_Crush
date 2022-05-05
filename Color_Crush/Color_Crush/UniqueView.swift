//
//  UniqueView.swift
//  Color_Crush
//
//  Created by nighthao on 2022/5/2.
//

import SwiftUI

struct UniqueView: View {
    @Binding var showUniqueView:Bool
    struct diamond_attribute{
        let id = UUID()
        var shape = Image(systemName: "diamond.fill")
        var color = Color.clear
        var choiced: Bool = false
        var opacity: Double = 0
        var offset = CGSize.zero
        var previousOffset = CGSize.zero
    }
    
    struct color_and_shape{
        var color = Color.red
        var shape = Image(systemName: "diamond.fill")
    }
    
    //時間
    @State private var timeRemaining = 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var tie:Bool = false
    @State var diamonds:[[diamond_attribute]] = Array(repeating: Array(repeating: diamond_attribute(), count: 5), count: 6)
    @State var isMan:Bool?
    @State private var scale: CGFloat = 1
    @State var moveDistance: Double = 0
    @State var test_diamond:diamond_attribute = diamond_attribute()
    @State var score:Int = 0
    @State var temp_score:Int = 0
    @State var shows:[[Bool]] = Array(repeating: Array(repeating: false, count: 5), count: 6)
    @State var history:Int = 0
    @State var progress:Double = 1
    
    func rewrite(){
        if score > history{
            history = score
        }
    }
    
    //隨機特殊寶石
    func random_unique(i:Int, j:Int){
        if i == 0 || i == 5{
            if j == 2{
                random_diamond(i: i, j: j)
            }
            else{
                diamonds[i][j].color = Color.clear
            }
        }
        else if i == 1 || i == 4{
            if j == 0 || j == 4{
                diamonds[i][j].color = Color.clear
            }
            else{
                random_diamond(i: i, j: j)
            }
        }
        else{
            random_diamond(i: i, j: j)
        }
    }
    
    //隨機寶石
    func random_diamond(i:Int,j:Int){
        let num = Int.random(in: 1...5)
        if num == 1{
            diamonds[i][j].shape = Image(systemName: "diamond.fill")
            diamonds[i][j].color = (Color(red: 0.9176470588235294, green: 0.12549019607843137, blue: 0.15294117647058825))
        }
        else if num == 2{
            diamonds[i][j].shape = Image(systemName: "rectangle.fill")
            diamonds[i][j].color = Color(red: 1.0, green: 0.9803921568627451, blue: 0.396078431372549)
        }
        else if num == 3{
            diamonds[i][j].shape = Image(systemName: "suit.diamond.fill")
            diamonds[i][j].color = Color(red: 0.22745098039215686, green: 0.8901960784313725, blue: 0.4549019607843137)
            
        }
        else if num == 4{
            diamonds[i][j].shape = Image(systemName: "seal.fill")
            diamonds[i][j].color = Color(red: 0.44313725490196076, green: 0.34509803921568627, blue: 0.8862745098039215)
        }
        else{
            diamonds[i][j].shape = Image(systemName: "circle.fill")
            diamonds[i][j].color = Color(red: 0.09411764705882353, green: 0.8627450980392157, blue: 1.0)
        }
    }
    
    func unique_judge(i:Int, j:Int) -> Color{
        if i == 0 || i == 5{
            if j == 2{
                return Color.accentColor
            }
            else{
                return Color.clear
            }
        }
        else if i == 1 || i == 4{
            if j == 0 || j == 4{
                return Color.clear
            }
            else{
                return Color.accentColor
            }
        }
        else{
            return Color.accentColor
        }
    }
    
    //判斷是否有三消存在
    func three_match_judgement() -> Bool{
        for i in 0...5{
            for j in 0...4{
                //向上
                if (i-1 == 1 && j == 0) || (i-1==1 && j == 4){
                    
                }
                else{
                    if i - 1 >= 1{
                        var temp_x = j
                        var temp_y = i - 1
                        var calcumulate:Int = 1
                        while temp_x > 0{
                            if diamonds[i-1][temp_x - 1].color == diamonds[i][j].color{
                                calcumulate += 1
                                temp_x -= 1
                            }
                            else{
                                break
                            }
                        }
                        while temp_x < 4{
                            if diamonds[i-1][temp_x + 1].color == diamonds[i][j].color{
                                calcumulate += 1
                                temp_x += 1
                            }
                            else{
                                break
                            }
                        }
                        if calcumulate >= 3{
                            return true
                        }
                        else{
                            calcumulate = 1
                        }
                        while temp_y > 0{
                            if diamonds[temp_y-1][j].color == diamonds[i][j].color{
                                calcumulate += 1
                                temp_y -= 1
                            }
                            else{
                                break
                            }
                        }
                        if calcumulate >= 3{
                            return true
                        }
                    }
                }
                //down
                if (i+1 == 4 && j == 0) || (i+1==4 && j == 4){
                    
                }
                else{
                    if i + 1 <= 4{
                        var temp_x = j
                        var temp_y = i + 1
                        var calcumulate:Int = 1
                        while temp_x > 0{
                            if diamonds[i+1][temp_x - 1].color == diamonds[i][j].color{
                                calcumulate += 1
                                temp_x -= 1
                            }
                            else{
                                break
                            }
                        }
                        while temp_x < 4{
                            if diamonds[i+1][temp_x + 1].color == diamonds[i][j].color{
                                calcumulate += 1
                                temp_x += 1
                            }
                            else{
                                break
                            }
                        }
                        if calcumulate >= 3{
                            return true
                        }
                        else{
                            calcumulate = 1
                        }
                        while temp_y < 5{
                            if diamonds[temp_y+1][j].color == diamonds[i][j].color{
                                calcumulate += 1
                                temp_y += 1
                            }
                            else{
                                break
                            }
                        }
                        if calcumulate >= 3{
                            return true
                        }
                    }
                }
                //left
                if (j-1 == 0 && i == 1) || (j+1==4 && i == 1){
                    
                }
                else{
                    if j - 1 >= 0{
                        var temp_x = j - 1
                        var temp_y = i
                        var calcumulate:Int = 1
                        while temp_x > 0{
                            if diamonds[i][temp_x - 1].color == diamonds[i][j].color{
                                calcumulate += 1
                                temp_x -= 1
                            }
                            else{
                                break
                            }
                        }
                        if calcumulate >= 3{
                            return true
                        }
                        else{
                            calcumulate = 1
                        }
                        while temp_y < 5{
                            if diamonds[i][j].color == diamonds[temp_y+1][j-1].color{
                                calcumulate += 1
                                temp_y += 1
                            }
                            else{
                                break
                            }
                        }
                        while temp_y > 0{
                            if diamonds[i][j].color == diamonds[temp_y-1][j-1].color{
                                calcumulate += 1
                                temp_y -= 1
                            }
                            else{
                                break
                            }
                        }
                        if calcumulate >= 3{
                            return true
                        }
                    }
                }
                //right
                if (j-1 == 0 && i == 4) || (j+1==4 && i == 4){
                    
                }
                else{
                    if j + 1 <= 4{
                        var temp_x = j + 1
                        var temp_y = i
                        var calcumulate:Int = 1
                        while temp_x < 4{
                            if diamonds[i][temp_x + 1].color == diamonds[i][j].color{
                                calcumulate += 1
                                temp_x += 1
                            }
                            else{
                                break
                            }
                        }
                        if calcumulate >= 3{
                            return true
                        }
                        else{
                            calcumulate = 1
                        }
                        while temp_y > 0{
                            if diamonds[temp_y-1][j+1].color == diamonds[i][j].color{
                                calcumulate += 1
                                temp_y -= 1
                            }
                            else{
                                break
                            }
                        }
                        while temp_y < 5{
                            if diamonds[temp_y+1][j+1].color == diamonds[i][j].color{
                                calcumulate += 1
                                temp_y += 1
                            }
                            else{
                                break
                            }
                        }
                        if calcumulate >= 3{
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    
    //三消
    func three_match() -> Bool{
        for i in 0...5{
            for j in 0...4{
                var tmp_col = i
                var up_col = i
                var down_col = i
                var tmp_row = j
                var left_row = j
                var right_row = j
                var col_calcumulate:Int = 1
                var row_calcumulate:Int = 1
                var check: Bool = false
                //up
                tmp_col = i - 1
                while(tmp_col >= 0){
                    if diamonds[i][j].color == diamonds[tmp_col][j].color{
                        col_calcumulate += 1
                        up_col = tmp_col
                        tmp_col -= 1
                    }
                    else{
                        break
                    }
                }
                //down
                tmp_col = i + 1
                while(tmp_col <= 5){
                    if diamonds[i][j].color == diamonds[tmp_col][j].color{
                        col_calcumulate += 1
                        down_col = tmp_col
                        tmp_col += 1
                    }
                    else{
                        break
                    }
                }
                if col_calcumulate >= 3{
                    check = true
                    print(j,"col",col_calcumulate,up_col,down_col)
                    for k in up_col...down_col{
                        if k != i{
                            //diamonds[k][j] = ?
                            shows[k][j] = true
                            diamonds[k][j].color = .blue
                            
                        }
                    }
                    print("col_score",(col_calcumulate-2)*100)
                    score += (col_calcumulate-2)*100
                }
                //left
                tmp_row = j - 1
                while(tmp_row >= 0){
                    if diamonds[i][j].color == diamonds[i][tmp_row].color{
                        row_calcumulate += 1
                        left_row = tmp_row
                        tmp_row -= 1
                    }
                    else{
                        break
                    }
                }
                //right
                tmp_row = j + 1
                while(tmp_row <= 4){
                    if diamonds[i][j].color == diamonds[i][tmp_row].color{
                        row_calcumulate += 1
                        right_row = tmp_row
                        tmp_row += 1
                    }
                    else{
                        break
                    }
                }
                if row_calcumulate >= 3{
                    check = true
                    print(i,"row",row_calcumulate, left_row, right_row)
                    for k in left_row...right_row{
                        if k != j{
                            //diamonds[i][k] = ?
                            shows[i][k] = true
                            diamonds[i][k].color = .blue
                            
                        }
                    }
                    print("row_score",(row_calcumulate-2)*100)
                    score += (row_calcumulate-2)*100
                }
                if check == true{
                    shows[i][j] = true
                    diamonds[i][j].color = .blue
                    return true
                }
            }
        }
        return false
    }
    
    //落下動畫
    func descent_animate(i:Int,j:Int, tmp_col:Int){
        /*diamonds[i][j].shape
            .offset(x:0, y: Double(65*(tmp_col-i)))
            .animation(.linear(duration: 1), value: Double(65*(tmp_col - i)))*/
        if diamonds[tmp_col][j].color != Color.clear{
            diamonds[i][j] = diamonds[tmp_col][j]
            shows[i][j] = false
            diamonds[tmp_col][j].color = Color.blue
        }
        else{
            random_diamond(i: i, j: j)
            shows[i][j] = false
        }
    }
    
    //落下寶石
    func diamonds_descent(){
        for j in 0...4{
            for i in stride(from: 5, through: 1, by: -1){
                if diamonds[i][j].color == Color.blue{
                    var tmp_col = i - 1
                    while (tmp_col >= 0){
                        if diamonds[tmp_col][j].color != Color.blue{
                            /*diamonds[tmp_col][j].shape
                                .offset(x:0, y:move_distance)
                                .animation(.easeOut(duration: 1), value: move_distance)*/
                            descent_animate(i: i, j: j, tmp_col: tmp_col)
                            /*diamonds[tmp_col][j].shape.offset(x:0, y:-move_distance)
                                .animation(.easeOut(duration: 1), value: move_distance)*/
                            break
                        }
                        tmp_col -= 1
                    }
                }
            }
        }
        for i in 0...5{
            for j in 0...4{
                if diamonds[i][j].color == Color.blue{
                    random_unique(i: i, j: j)
                    shows[i][j] = false
                }
            }
        }
    }
    
    func initial(){
        diamonds = Array(repeating: Array(repeating: diamond_attribute(), count: 5), count: 6)
        tie = false
        progress = 1
        timeRemaining = 60
        for i in 0...5{
            for j in 0...4{
                random_unique(i: i, j: j)
            }
        }
        while(three_match()){
            diamonds_descent()
        }
        if three_match_judgement() == false{
            print("Hi")
            initial()
        }
        score = temp_score
        if score > history{
            history = score
        }
    }
    
    @State var show = false
    var body: some View {
        ZStack{
            Image("Image")
                .resizable()
        VStack(spacing: 5.0){
            Text("剩餘\(timeRemaining)秒")
                .onReceive(timer) { time in
                    if self.timeRemaining > 0 {
                        self.timeRemaining -= 1
                    }
                    else{
                        tie = true
                    }
                }
                .font(.largeTitle)
            HStack(spacing: 80){
                Text("Score:\(score)")
                    .font(.largeTitle)
                Text("History:\(history)")
                    .font(.largeTitle)
            }
            Button("Random"){
                initial()
            }
            ProgressView(value: progress).frame(height: 20)
            ZStack{
                VStack(alignment: .center, spacing: 0.5) {
                    ForEach(0..<6) { i in
                        HStack(spacing: 0.5) {
                            ForEach(0..<5) { j in
                                Rectangle()
                                    .frame(width: 65, height: 65)
                                    .foregroundColor(unique_judge(i: i, j: j))
                            }
                        }
                    }
                }
                VStack(alignment: .center, spacing: 0.5) {
                    ForEach(0..<6) { i in
                        HStack(spacing: 0.5) {
                            ForEach(0..<5) { j in
                                ZStack{
                                diamonds[i][j].shape
                                    .foregroundColor(diamonds[i][j].color)
                                    .frame(width: 65, height: 65)
                                    .transition(.opacity)
                                    .offset(diamonds[i][j].offset)
                                    .gesture(
                                    DragGesture()
                                        .onChanged{ value in
                                            withAnimation(.spring()){
                                                diamonds[i][j].offset = value.translation
                                            }
                                        }
                                        .onEnded{ value in
                                            withAnimation(.spring()){
                                                if diamonds[i][j].offset.width < -45{
                                                diamonds[i][j].offset = .zero
                                                var tmp_diamond: diamond_attribute = diamonds[i][j]
                                                diamonds[i][j] = diamonds[i][j-1]
                                                diamonds[i][j-1]=tmp_diamond
                                                    if(three_match()){
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                                        diamonds_descent()
                                                            while(three_match()){
                                                                diamonds_descent()
                                                            }
                                                            temp_score = score
                                                            if (three_match_judgement() == false){
                                                                initial()
                                                            }
                                                        }
                                                    }
                                                    else{
                                                        var tmp_diamond: diamond_attribute = diamonds[i][j]
                                                        diamonds[i][j] = diamonds[i][j-1]
                                                        diamonds[i][j-1]=tmp_diamond
                                                    }
                                                }
                                                else if diamonds[i][j].offset.width > 45{
                                                    diamonds[i][j].offset = .zero
                                                    var tmp_diamond: diamond_attribute = diamonds[i][j]
                                                    diamonds[i][j] = diamonds[i][j+1]
                                                    diamonds[i][j+1]=tmp_diamond
                                                    if(three_match()){
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                                        diamonds_descent()
                                                            while(three_match()){
                                                                diamonds_descent()
                                                            }
                                                            temp_score = score
                                                            if (three_match_judgement() == false){
                                                                initial()
                                                            }
                                                        }
                                                    }
                                                    else{
                                                        var tmp_diamond: diamond_attribute = diamonds[i][j]
                                                        diamonds[i][j] = diamonds[i][j+1]
                                                        diamonds[i][j+1]=tmp_diamond
                                                    }
                                                }
                                                else if diamonds[i][j].offset.height < -45{
                                                    diamonds[i][j].offset = .zero
                                                    var tmp_diamond: diamond_attribute = diamonds[i][j]
                                                    diamonds[i][j] = diamonds[i-1][j]
                                                    diamonds[i-1][j]=tmp_diamond
                                                    if(three_match()){
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                                        diamonds_descent()
                                                            while(three_match()){
                                                                diamonds_descent()
                                                            }
                                                            temp_score = score
                                                            if (three_match_judgement() == false){
                                                                initial()
                                                            }
                                                        }
                                                    }
                                                    else{
                                                        var tmp_diamond: diamond_attribute = diamonds[i][j]
                                                        diamonds[i][j] = diamonds[i-1][j]
                                                        diamonds[i-1][j]=tmp_diamond
                                                    }
                                                }
                                                else if diamonds[i][j].offset.height > 45{
                                                    diamonds[i][j].offset = .zero
                                                    var tmp_diamond: diamond_attribute = diamonds[i][j]
                                                    diamonds[i][j] = diamonds[i+1][j]
                                                    diamonds[i+1][j]=tmp_diamond
                                                    if(three_match()){
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                                        diamonds_descent()
                                                            while(three_match()){
                                                                diamonds_descent()
                                                            }
                                                            temp_score = score
                                                            if (three_match_judgement() == false){
                                                                initial()
                                                            }
                                                        }
                                                    }
                                                    else{
                                                        var tmp_diamond: diamond_attribute = diamonds[i][j]
                                                        diamonds[i][j] = diamonds[i+1][j]
                                                        diamonds[i+1][j]=tmp_diamond
                                                    }
                                                }
                                            }
                                        }
                                    )
                                
                                }.animation(.easeInOut(duration:1), value:shows[i][j])
                                
                                
                        }
                        }
                    }
                }
                if tie == true{
                    VStack{
                        Button{
                            tie = false
                            rewrite()
                            temp_score = 0
                            initial()
                        }label: {
                            Text("Next Round")
                                .padding()
                                .foregroundColor(.mint)
                                .font(.largeTitle)
                        }
                        Button{
                            showUniqueView = false
                            
                        }label: {
                            Text("Home")
                                .padding()
                                .foregroundColor(.mint)
                                .font(.largeTitle)
                        }
                    }
                }
            }
            /*ZStack{
                VStack(alignment: .center) {
                    ForEach(0..<8) { i in
                        HStack {
                            ForEach(0..<8) { j in
                                Circle()
                                    .stroke(ChoicedColor(x: i, y: j),lineWidth:8)
                                    .frame(width: 42, height: 42)
                                    .opacity(ChoicedOp(x: i, y: j))
                            }
                        }
                    }
                }
                VStack(alignment: .center) {
                    ForEach(0..<8) { i in
                        HStack {
                            ForEach(0..<8) { j in
                                Circle()
                                    .frame(width: 42, height: 42)
                                    .foregroundColor(checker[i][j].color)
                                    .opacity(checker[i][j].opacity)
                                    .onTapGesture {
                                        TapCheck(i: i, j: j)
                                    }
                            }
                        }
                    }
                }
                VStack(alignment: .center) {
                    ForEach(0..<8) { i in
                        HStack {
                            ForEach(0..<8) { j in
                                Text("K")
                                    .padding(.all, 13.0)
                                    .frame(width: 42, height: 42)
                                    .foregroundColor(.green)
                                    .opacity(king_check(i: i, j: j))
                            }
                        }
                    }
                }
                VStack{
                    if best_color != ""{
                        Button(best_color){
                            showContentView = false
                        }.font(.largeTitle)
                    }
                }
            }*/
            
        }
    }
}
}

struct UniqueView_Previews: PreviewProvider {
    static var previews: some View {
        UniqueView(showUniqueView: .constant(true))
    }
}
